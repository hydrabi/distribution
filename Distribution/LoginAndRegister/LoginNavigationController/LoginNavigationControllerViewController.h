//
//  LoginNavigationControllerViewController.h
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationController.h"
@interface LoginNavigationControllerViewController : NavigationController
+(instancetype)shareInstance;
-(void)showWithParent:(UIView *)parentView;
-(void)showWithRootViewController;
-(void)hide;
@end
