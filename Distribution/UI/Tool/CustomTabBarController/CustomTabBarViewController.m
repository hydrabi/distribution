//
//  CustomTabBarViewController.m
//  FoodDelivered
//
//  Created by Hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "NavigationController.h"
#import "HomeViewController.h"
#import "PersonalViewController.h"
#import "FavoriteViewController.h"
#import "EaseUI.h"
#import "EMSDKFull.h"
#import "DiscoverViewController.h"
#import "PersonalMainViewController.h"
#import "ShoppingCarViewController.h"
#import "ClassifyViewController.h"

static CGFloat tabBarHeight = 49;

@interface CustomTabBarViewController ()
/**
 *  添加控制器的内容View，用来定位
 */
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSArray *controllersArr;
@property (nonatomic,strong) UIViewController *currentController;
@end

@implementation CustomTabBarViewController

-(instancetype)initWithControllersArr:(NSArray*)arr{
    self = [super init];
    if(self){
        self.controllersArr = arr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
-(void)configUI{
    [self configControllersArr];
    [self configTabBar];
    [self configTabBarConstraint];
    [self addUpControllers];
}

-(void)configControllersArr{
    if(!_controllersArr){
        
        HomeViewController *vc = [[HomeViewController alloc] init];
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        
        ClassifyViewController *vc1 = [[ClassifyViewController alloc] init];
        NavigationController *nav1 = [[NavigationController alloc] initWithRootViewController:vc1];
        
        DiscoverViewController *vc2 = [[DiscoverViewController alloc] init];
        NavigationController *nav2 = [[NavigationController alloc] initWithRootViewController:vc2];
        
        ShoppingCarViewController *vc3 = [[ShoppingCarViewController alloc] init];
        NavigationController *nav3 = [[NavigationController alloc] initWithRootViewController:vc3];
        
        PersonalMainViewController *vc4 = [[PersonalMainViewController alloc] init];
        NavigationController *nav4 = [[NavigationController alloc] initWithRootViewController:vc4];
        _controllersArr = @[nav,
                            nav1,
                            nav2,
                            nav3,
                            nav4];
    }
}

-(UIView*)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

-(void)configTabBar{
    if(!_tabBar){
        self.tabBar = [CustomTabBar customFoodDeliverTabBar];
        self.tabBar.delegate = self;
        [self.view addSubview:self.tabBar];
    }
}

-(void)configTabBarConstraint{
    [self.tabBar remakeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
        make.height.equalTo(@(tabBarHeight));
        make.bottom.equalTo(self.view.bottom);
        make.top.equalTo(self.contentView.bottom);
    }];
    
    [self.contentView remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.top);
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
    }];
}

-(void)hideTabbar{
    [self.tabBar remakeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
        make.height.equalTo(@(tabBarHeight));
        make.bottom.equalTo(self.view.bottom).offset(tabBarHeight);
        make.top.equalTo(self.contentView.bottom);
    }];
    
    [self.contentView remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.top);
        make.leading.equalTo(self.view.leading);
        make.trailing.equalTo(self.view.trailing);
    }];
}

-(void)configCurrentControllerConstraint{
    [self.currentController.view remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.contentView.top);
        make.leading.equalTo(self.contentView.leading);
        make.trailing.equalTo(self.contentView.trailing);
        make.bottom.equalTo(self.contentView.bottom);
    }];
}

-(void)addUpControllers{
    for(int i=0;i<self.controllersArr.count;i++){
        UINavigationController *vc = self.controllersArr[i];
        [self addChildViewController:vc];
        if([self.tabBar getCurrentIndex] == i){
            [self.contentView addSubview:vc.view];
            [vc didMoveToParentViewController:self];
            self.currentController = vc;
            [self configCurrentControllerConstraint];
        }
    }
}

-(void)switchToControllerWithIndex:(NSInteger)index{
    if(self.controllersArr.count>index){
        [self.currentController willMoveToParentViewController:self];
        [self.currentController.view removeFromSuperview];
        
        UINavigationController *vc = self.controllersArr[index];
        self.currentController = vc;
        [self.contentView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        [self configCurrentControllerConstraint];
    }
}

#pragma mark - CustomTabBarDelegate

-(void)CustomTabBar:(CustomTabBar*)tabBar selectedIndex:(NSInteger)index{
    
    [self switchToControllerWithIndex:index];
}
@end
