//
//  HomeViewController.m
//  Distribution
//
//  Created by Hydra on 15/12/16.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "HomeViewController.h"
#import "SCNavTabBarController.h"
#import "CustomizedCollectionViewController.h"
#import "CommonMacro.h"
#import "UIColor+Addition.h"
#import "AppDelegate.h"
#import "CustomizedCollectionViewControllerDelegate.h"
#import "CommodityDetailsViewController.h"
#import "SharePopSelectViewDelegate.h"
#import "NSArray+Addition.h"
#import "PersonalMacro.h"
#import "SearchProductViewController.h"
#import "ClassifyView.h"

#define searchBarWidthPer   0.8f
#define searchBarHeight     30.0f
#define leftLogoWidth       72.0f
@interface CustomSearchBar : UISearchBar

@end

@implementation CustomSearchBar

-(void)setFrame:(CGRect)frame{
    [super setFrame:CGRectMake(leftLogoWidth+(SCREEN_WIDTH-leftLogoWidth)*(1-searchBarWidthPer)/2,(CGRectGetHeight(frame)-searchBarHeight)/2, (SCREEN_WIDTH-leftLogoWidth)*searchBarWidthPer+12, searchBarHeight)];
}

@end

@interface HomeViewController ()<CustomizedCollectionViewControllerDelegate,UISearchBarDelegate>

@property (nonatomic,strong)SCNavTabBarController *navTabBar;
/**顶部titleView为searchBar*/
@property (nonatomic,strong)UISearchBar *searchBar;
/**分类控制器*/
@property (nonatomic,weak)CustomizedCollectionViewController *classifyController;
/**searchBar查找工具*/
@property (nonatomic,strong)AVQuery *searchBarQuery;
/**
 *  表示正在查询中
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;

@property (strong,nonatomic) ClassifyView *classifyView;
@end

@implementation HomeViewController

-(MBProgressHUD*)progressHUD{
    if(!_progressHUD){
        RootViewController *vc = [AppDelegate getRootController];
        _progressHUD = [[MBProgressHUD alloc] initWithView:vc.view];
        _progressHUD.mode     = MBProgressHUDModeIndeterminate;
        _progressHUD.labelText = @"正在查询...";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_progressHUD addGestureRecognizer:tap];
    }
    return _progressHUD;
}

-(ClassifyView*)classifyView{
    if(!_classifyView){
        _classifyView = [[ClassifyView alloc] initWithParentView:self.navigationController.view];
    }
    return _classifyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarController];
    [self UIConfig];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

#pragma mark - UI
-(void)UIConfig{
    self.navigationItem.leftBarButtonItems = [NSArray navigationItemsWithImageName:@"navigation_logo" target:self selecter:@selector(logoClick)];
    [self searchBarConfig];
}
//创建子视图
-(void)configureTabBarController{
    CustomizedCollectionViewController *vc1 = [[CustomizedCollectionViewController alloc] init];
    vc1.homeDelegate = self;
    vc1.pdType = productType_new;
    vc1.title = @"上新";
    
    CustomizedCollectionViewController *vc2 = [[CustomizedCollectionViewController alloc] init];
    vc2.homeDelegate = self;
    vc2.pdType = productType_special;
    vc2.title = @"特批";
    
    CustomizedCollectionViewController *vc3 = [[CustomizedCollectionViewController alloc] init];
    vc3.homeDelegate = self;
    vc3.pdType = productType_all;
    vc3.title = @"全部";
    
    CustomizedCollectionViewController *vc4 = [[CustomizedCollectionViewController alloc] init];
    vc4.homeDelegate = self;
    vc4.pdType = productType_forwardSale;
    vc4.title = @"预售";
    self.classifyController = vc4;
    
    self.navTabBar                    = [[SCNavTabBarController alloc] init];
    self.navTabBar.subViewControllers = @[vc1,
                                          vc2,
                                          vc3,
                                          vc4];
    self.navTabBar.showArrowButton    = NO;
    self.navTabBar.homeDelegate       = self;
    [self.navTabBar addParentController:self];
    
}

#pragma mark - searchBar

-(void)searchBarConfig{
    self.searchBar                                           = [[CustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.7, 30.0f)];
    self.searchBar.layer.borderColor = [UIColor colorWithHexString:@"b4b4b4" alpha:1].CGColor;
    self.searchBar.layer.borderWidth = 1.0f;
    self.searchBar.layer.cornerRadius = 5.0f;
    self.searchBar.clipsToBounds = YES;
    self.searchBar.translatesAutoresizingMaskIntoConstraints = YES;
    self.searchBar.backgroundColor                           = [UIColor clearColor];
    self.searchBar.delegate                                  = self;
    [self.searchBar setBarStyle:UIBarStyleDefault];
    [self.searchBar setContentMode:UIViewContentModeLeft];
    self.searchBar.placeholder                               = @"产品关键字搜索";
    for (UIView *subview in self.searchBar.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
            break;
        }
    }
    self.navigationItem.titleView                            = self.searchBar;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchStr = searchBar.text;
    [self showProgress];
    self.searchBarQuery = [RequestData queryProductWithSearchBarText:searchStr completion:^(NSArray *results,NSError *error){
        if(results.count>0){
            [self.searchBar resignFirstResponder];
            SearchProductViewController *vc = [[SearchProductViewController alloc] initWithDataArr:results];
            [self.navigationController pushViewController:vc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
        else {
            [MBProgressHUD showError:@"无搜索结果！"];
        }
        [self hideProgress];
    }];
}

-(void)showProgress{
    if(!self.progressHUD.superview){
        RootViewController *vc = [AppDelegate getRootController];
        [vc.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
    }
}

-(void)hideProgress{
    [self.progressHUD hide:YES];
    [self.progressHUD removeFromSuperview];
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self.searchBarQuery cancel];
    [self hideProgress];
}


#pragma mark - action
-(void)logoClick{
    
}

-(void)show{
    
}

#pragma mark - navBar调用
-(void)resignSerchBarFirstResponse{
    if([self.searchBar isFirstResponder]){
        [self.searchBar resignFirstResponder];
    }
    
}

-(void)hadScrollToViewWithIndex:(NSInteger)index{
    NSArray *vcArr = self.navTabBar.subViewControllers;
    if(vcArr.count>index){
        CustomizedCollectionViewController *vc = (CustomizedCollectionViewController*)vcArr[index];
        [vc refreshIfShould];
    }
}

-(void)hadSelectSharePopSelectTableViewCellType:(productType)type{
    self.classifyController.pdType = type;
    [self.classifyController refreshIfShould];
}

-(void)showClassifyView{
    [self.classifyView show];
}

#pragma mark - CustomizedCollectionViewControllerDelegate
-(void)pushIntoCommodityDitailsControllerWithIndexPath:(NSIndexPath *)indexPath object:(AVObject *)object{
    CommodityDetailsViewController *vc = [[CommodityDetailsViewController alloc] initWithObject:object];
    [self.navigationController pushViewController:vc animated:YES];
    [[AppDelegate getRootController]hideTabbar];
    
}

#pragma mark - 登录状态改变
-(void)loginStatusChange{
    for(CustomizedCollectionViewController *vc in self.navTabBar.subViewControllers){
        [vc refreshIfShould];
    }
}
@end
