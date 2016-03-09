//
//  PresentViewDelegate.h
//  Distribution
//
//  Created by Hydra on 15/12/29.
//  Copyright © 2015年 distribution. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol presentViewDelegate <NSObject>

@optional

-(void)resignConstraintWithNextResponderFrame:(CGRect)frame;

/**
 *  登录，注册成功后的回调
 */
-(void)operationCompetition;

/**
 *  重新设置密码后返回登陆页面
 */
-(void)setDefaultViewType;

@end
