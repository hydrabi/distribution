//
//  AppDelegate+OpenShare.m
//  Distribution
//
//  Created by Hydra on 16/1/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "AppDelegate+OpenShare.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "CustomShare.h"
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
@implementation AppDelegate (OpenShare)

- (void)openShareApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WXApi registerApp:WeiXinAppId];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WeiboAppKey];
}

- (BOOL)openShareApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        return [QQApiInterface handleOpenURL:url delegate:[CustomShare shareManager]];
        
    }
    else if([[url absoluteString] hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:[CustomShare shareManager]];
        
    }
    else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:[CustomShare shareManager]];
        
    }
    return NO;
}

- (BOOL)openShareApplication:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
        
    }
    else if([[url absoluteString] hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:[CustomShare shareManager]];
        
    }
    else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:[CustomShare shareManager]];
        
    }
    return YES;
}

@end
