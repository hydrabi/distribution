//
//  RootViewController.m
//  FoodDelivered
//
//  Created by Hydra on 15/11/28.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import "RootViewController.h"
#import "Reachability.h"
#import "CustomTabBarButton.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addReachabilityNotification];
    //发送显示badge
    [self showBadgeWithButtonType:CustomTabBarButtonType_discover];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReachabilityNotification
-(void)addReachabilityNotification{
    Reachability* reach = [Reachability reachabilityForInternetConnection];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];
}

-(void)reachabilityChanged:(NSNotification*)note{
    Reachability * reach = [note object];
    NetworkStatus statu=[reach currentReachabilityStatus];
    if(statu==NotReachable)
    {
        [MBProgressHUD showError:@"网络连接失败"];
    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - showBadge
-(void)showBadgeWithButtonType:(CustomTabBarButtonType)buttonType{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationKey_BadgeShow object:nil userInfo:@{NSNotificationUserInfoKey_BadgeButtonType:@(buttonType)}];
}

@end
