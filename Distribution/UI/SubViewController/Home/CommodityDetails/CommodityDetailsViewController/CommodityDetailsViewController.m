//
//  CommodityDetailsViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CommodityDetailsViewController.h"
#import "CommodityDetailsDataSource.h"
#import "AppDelegate.h"
#import "CommodityDetailsMacro.h"
#import "CommodityDetailsDataSourceDelegate.h"
#import "UIColor+Addition.h"
#import "CustomMWPhotoBrowser.h"
#import "RequestData.h"
#import "NSArray+Addition.h"
#import "CustomShare.h"
#import "CustomImageAndTitleButton.h"
#import "LoginNavigationControllerViewController.h"

@interface CommodityDetailsViewController ()<CommodityDetailsDataSourceDelegate,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *photos;
/**
 *  数据源
 */
@property (strong,nonatomic) CommodityDetailsDataSource *dataSource;
/**
 *  查询任务
 */
@property (strong,nonatomic) NSURLSessionDataTask *task;
/**
 *  弹出的正在刷新提示
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;
/**
 *  商品
 */
@property (strong,nonatomic) AVObject *object;

@property (weak,nonatomic)IBOutlet CustomImageAndTitleButton *collectButton;
@property (weak,nonatomic)IBOutlet UIButton *shoppingCarButton;
@property (weak,nonatomic)IBOutlet UIButton *purchaseButton;
@end

@implementation CommodityDetailsViewController

-(instancetype)initWithObject:(AVObject *)object{
    self = [super init];
    if(self){
        self.object = object;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTrack];
    [self configUI];
    [self progressHUDConfig];
    [self configDataSoucre];
    [self navigationItemConfig];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    NSLog(@"CommodityDetailsViewController商品详情资源已被释放");
}

#pragma mark - configTrace
//添加足迹
-(void)configTrack{
    AVUser *user = [AVUser currentUser];
    if(user){
        [user addTraceWithObject:self.object];
    }
}

#pragma mark - configUI
-(void)configUI{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout                       = UIRectEdgeNone;///选择UIRectedgenone，视图的内容不会延伸到navigationbar的后面，就是不会顶穿导航栏
        self.extendedLayoutIncludesOpaqueBars             = NO;///这个属性指定了当bar使用了不透明图片时，视图是否延伸到bar所在区域，默认为NO
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.title = @"商品详情";
    self.tableView.backgroundColor = CommodityDetailsTableViewBackgroundColor;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self buttonUIConfig];
}

-(void)buttonUIConfig{
//    [self.collectButton configButtonImageName:@"favoriteButtonHeart" title:@"收藏" middleOffset:5.0f buttonHeight:CommodityDetailsFavoriteButtonHeight titleFont:[UIFont systemFontOfSize:15.0f]];
//    [self.collectButton setTitleColor:[UIColor colorWithHexString:@"ff4400" alpha:1] forState:UIControlStateNormal];
    [self.collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    AVUser *user                   = [AVUser currentUser];
    if(user){
        BOOL favorited                 = [user containFavoriteObjectId:self.object.objectId];
        [self hadAddFavorite:favorited];
    }
    
    
    [self.shoppingCarButton setBackgroundColor:[UIColor colorWithHexString:@"ff4400" alpha:0.6]];
    [self.shoppingCarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.shoppingCarButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    self.shoppingCarButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [self.purchaseButton setBackgroundColor:[UIColor colorWithHexString:@"ff4400" alpha:1]];
    [self.purchaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.purchaseButton setTitle:@"点击购买" forState:UIControlStateNormal];
    self.purchaseButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
}

-(void)progressHUDConfig{
    //圆形进度条
    self.progressHUD          = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    self.progressHUD.mode     = MBProgressHUDModeIndeterminate;
}

#pragma mark - 点击事件
//购买
-(void)purchaseButtonClick:(UIButton*)button{
    
}
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)shareButtonClick{
    [[CustomShare shareManager] showShareMenuWithObject:self.object];
}

/**按钮点击事件*/
-(void)collectButtonClick{
    AVUser *user = [AVUser currentUser];
    //已经登录
    if(user){
        BOOL favorited = [user containFavoriteObjectId:self.object.objectId];
        //未加入收藏，商品加入收藏
        if(!favorited){
            [user addFavoriteWithObjectId:self.object];
            [MBProgressHUD showSuccess:@"加入收藏成功！"];
            [self hadAddFavorite:YES];
            
        }
        else{
            [user removeFavoriteWithObjectId:self.object];
            [MBProgressHUD showSuccess:@"取消收藏成功！"];
            [self hadAddFavorite:NO];
            
        }
    }
    //未登录，弹出登录框
    else{
        [[LoginNavigationControllerViewController shareInstance] showWithRootViewController];
    }
}

#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[CommodityDetailsDataSource alloc] initWithTableView:self.tableView object:self.object];
    self.dataSource.delegate = self;
}

-(void)navigationItemConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(shareButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark - CommodityDetailsDataSourceDelegate
-(void)imageClickWithArr:(NSMutableArray*)imageArr clickedIndex:(NSInteger)index{
    MWPhoto *photo;
    NSMutableArray *photos = @[].mutableCopy;
    for(NSInteger i = 0;i<imageArr.count;i++){
        NSString *imageName = imageArr[i];
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:imageName]];
        //图片描述
        photo.caption = @"";
        [photos addObject:photo];
    }
    
    self.photos = photos;
    // Create browser
    CustomMWPhotoBrowser *browser = [[CustomMWPhotoBrowser alloc] initWithDelegate:self];
    //右上角按钮
    browser.displayActionButton = YES;
    //底部页面切换toolBar
    browser.displayNavArrows = NO;
    //选择按钮
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = NO;
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
    
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}


#pragma mark - 收藏

/**根据是否收藏按钮的显示状态不同*/
-(void)hadAddFavorite:(BOOL)favorite{
    UIFont *font                           = [UIFont systemFontOfSize:15.0f];
    //未加入收藏
    if(!favorite){
        [self.collectButton configButtonImageName:@"favoriteButtonHeart" title:@"收藏" middleOffset:5.0f buttonHeight:CommodityDetailsFavoriteButtonHeight titleFont:font];
        [self.collectButton setTitleColor:[UIColor colorWithHexString:@"ff4400" alpha:1] forState:UIControlStateNormal];
        
    }
    //已加入收藏
    else{
        [self.collectButton configButtonImageName:nil title:@"  取消收藏" middleOffset:5.0f buttonHeight:CommodityDetailsFavoriteButtonHeight titleFont:font];
        [self.collectButton setTitleColor:[UIColor colorWithHexString:@"3d3d3d" alpha:1] forState:UIControlStateNormal];
        
    }
}
@end
