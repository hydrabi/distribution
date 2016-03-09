//
//  CustomArrowButton.h
//  Distribution
//
//  Created by Hydra on 15/12/18.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import <UIKit/UIKit.h>

/**定制tabBar按钮类型*/
typedef NS_ENUM(NSInteger,NavTabBarButtonType) {
    NavTabBarButtonType_new,                /**<上新*/
    NavTabBarButtonType_approve,            /**<特批*/
    NavTabBarButtonType_all,                /**<全部*/
    NavTabBarButtonType_presell,            /**<预售*/
    NavTabBarButtonType_classify,           /**<分类*/
};

@interface CustomArrowButton : UIButton

-(instancetype)initWithFrame:(CGRect)frame barButtonType:(NavTabBarButtonType)type;

-(void)modifyTextColorWithSelectedOrNot:(BOOL)selected;

/**使按钮箭头向上*/
-(void)transformRotationAbove:(BOOL)above;

@end
