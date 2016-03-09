//
//  CustomTabBar.h
//  FoodDelivered
//
//  Created by Hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarDelegate.h"
@interface CustomTabBar : UIView

@property (nonatomic,weak) id<CustomTabBarDelegate> delegate;

-(instancetype)initWithButtonsArr:(NSArray*)buttonsArr defaultIndex:(NSInteger)defaultIndex;

+(CustomTabBar*)customFoodDeliverTabBar;

/**
 *  获取当前选中按钮
 *
 *  @return 当前选中的按钮
 */
-(CustomTabBarButton*)getCurrentSelectButton;

/**
 *  获取当前索引
 *
 *  @return 当前索引
 */
-(NSInteger)getCurrentIndex;

/**
 *  切换到指定的索引，并通知委托
 *
 *  @param index 指定的索引
 */
-(void)switchToSpecificIndex:(NSInteger)index;
@end
