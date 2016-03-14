//
//  NavigationController.m
//  Distribution
//
//  Created by Hydra on 15/12/16.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "NavigationController.h"
#import "PersonalViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ConversationListViewController.h"
#import "UIColor+Addition.h"
#import "DiscoverViewController.h"
#import "PersonalMainViewController.h"
#import "FavoriteViewController.h"
@interface NavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation NavigationController

+(void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor whiteColor];
    navBar.tintColor = [UIColor colorWithHexString:@"0f0f0f" alpha:1];
    navBar.titleTextAttributes = @{ NSFontAttributeName : Global_NavigationTitleFont,
                                    NSForegroundColorAttributeName : Global_NavigationTitleColor};
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self swipeToReturn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 使能滑动返回
-(void)swipeToReturn{
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:YES];
    [[AppDelegate getRootController] hideTabbar];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    navigationController.interactivePopGestureRecognizer.enabled = !isRootVC;
    
    if([viewController isKindOfClass:[HomeViewController class]]){
        [[AppDelegate getRootController] configTabBarConstraint];
        return;
    }
    if([viewController isKindOfClass:[DiscoverViewController class]]){
        [[AppDelegate getRootController] configTabBarConstraint];
        return;
    }
    if([viewController isKindOfClass:[PersonalMainViewController class]]){
        [[AppDelegate getRootController] configTabBarConstraint];
        return;
    }
//    if([viewController isKindOfClass:[FavoriteViewController class]]){
//        [[AppDelegate getRootController] configTabBarConstraint];
//    }
    
    [[AppDelegate getRootController] hideTabbar];
}

@end
