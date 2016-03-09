//
//  AppDelegate+Ease.h
//  Distribution
//
//  Created by Hydra on 16/1/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface AppDelegate (EaseMob)
- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig;
@end
