//
//  AppDelegate.m
//  Distribution
//
//  Created by Hydra on 15/12/7.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageManager.h"
#import "AppDelegate+Ease.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate+OpenShare.h"

#define EaseMobAppkey @"yyss2016#yyss"
#define AVCloundID @"9dibcmhsV9QeOFoiWBaQmpbS-gzGzoHsz"
#define AVCloundKey @"B2M1IKGroclg7SIO9X3CSood"
@interface AppDelegate ()
@end

@implementation AppDelegate

+(RootViewController*)getRootController{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return app.rootController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //环信注册
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:EaseMobAppkey
                apnsCertName:nil
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    //leanClound注册
    [AVOSCloud setApplicationId:AVCloundID clientKey:AVCloundKey];
    //同步数据
    [[PersonlInfoManager shareManager] AVUserAttributeSynchronize:^(AVObject *object, NSError *error){
        
    }];
    //分享注册
    [self openShareApplication:application didFinishLaunchingWithOptions:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootViewController *vc = [[RootViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    self.rootController = vc;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self openShareApplication:application handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self openShareApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
