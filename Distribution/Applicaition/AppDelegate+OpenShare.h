//
//  AppDelegate+OpenShare.h
//  Distribution
//
//  Created by Hydra on 16/1/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "OpenShare.h"
#import "OpenShare+QQ.h"
#import "OpenShare+Weibo.h"
#import "OpenShare+Weixin.h"
@interface AppDelegate (OpenShare)
- (void)openShareApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (BOOL)openShareApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)openShareApplication:(UIApplication *)application handleOpenURL:(NSURL *)url;
@end
