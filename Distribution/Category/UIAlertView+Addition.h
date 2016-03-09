//
//  UIAlert+Addition.h
//  YQTrack
//
//  Created by 毕志锋 on 15/7/17.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView(Addition)

/**
 *  只展示简单的消息提示
 *
 *  @param title 想要展示的消息
 */
+(void)alertWithTitle:(NSString*)title;

/**
 *  只展示简单的消息提示
 *
 *  @param title    想要展示的消息
 *  @param delegate 委托
 */
+(void)alertWithTitle:(NSString *)title delegate:(id<UIAlertViewDelegate>) delegate;

@end
