//
//  CustomTabBarViewController.h
//  FoodDelivered
//
//  Created by Hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarDelegate.h"
#import "CustomTabBar.h"
@interface CustomTabBarViewController : UIViewController<CustomTabBarDelegate>

/**
 *  定制的tabBar
 */
@property (nonatomic,strong) CustomTabBar *tabBar;

-(instancetype)initWithControllersArr:(NSArray*)arr;

-(void)hideTabbar;

-(void)configTabBarConstraint;

@end
