//
//  UIAlert+Addition.m
//  YQTrack
//
//  Created by 毕志锋 on 15/7/17.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "UIAlertView+Addition.h"
@implementation UIAlertView(Addition)

+(void)alertWithTitle:(NSString*)title{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+(void)alertWithTitle:(NSString *)title delegate:(id<UIAlertViewDelegate>) delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}

@end
