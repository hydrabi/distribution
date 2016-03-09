//
//  CustomTabBarButton.h
//  FoodDelivered
//
//  Created by hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import <UIKit/UIKit.h>

/**定制tabBar按钮类型*/
typedef NS_ENUM(NSInteger,CustomTabBarButtonType) {
    CustomTabBarButtonType_home,                    /**<首页*/
    CustomTabBarButtonType_favorite,                /**<收藏*/
    CustomTabBarButtonType_discover,                /**<发现*/
    CustomTabBarButtonType_personal                 /**<个人*/
};

/**
 定制tabbar的按钮
 */
@interface CustomTabBarButton : UIButton

-(instancetype)initWithButtonType:(CustomTabBarButtonType)type;

/**
 *  根据按钮的类型重新设置属性
 *
 *  @param highlighted yes，按钮被选中；no，按钮未被选中
 */
-(void)configAttributeWithHighlighted:(BOOL)highlighted;

/**
 *  获取按钮类型，分辨按钮
 *
 *  @return 按钮类型，为CustomTabBarButtonType枚举
 */
-(CustomTabBarButtonType)getButtonType;
@end
