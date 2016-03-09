//
//  CustomTabBarDelegate.h
//  FoodDelivered
//
//  Created by Hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomTabBar;
@class CustomTabBarButton;

@protocol CustomTabBarDelegate <NSObject>

@required

/**
 *  通知委托点击了tabbar按钮，按钮的tag为选中的索引，委托可根据此索引切换视图控制器
 *
 *  @param tabBar tabbar
 *  @param button 点击的按钮
 */
-(void)CustomTabBar:(CustomTabBar*)tabBar selectedIndex:(NSInteger)index;

@end
