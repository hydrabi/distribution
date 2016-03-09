//
//  AppDelegate.h
//  Distribution
//
//  Created by Hydra on 15/12/7.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *rootController;

+(RootViewController*)getRootController;
@end

