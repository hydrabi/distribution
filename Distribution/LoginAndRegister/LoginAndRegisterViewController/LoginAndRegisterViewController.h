//
//  LoginAndRegisterViewController.h
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterView.h"
#import "ForgetPasswordView.h"
#import "UIView+Addition.h"
#import "PersonalViewControllerDelegate.h"

typedef NS_ENUM(NSUInteger,CustomPresentViewType) {
    CustomPresentViewType_register,
    CustomPresentViewType_login,
    CustomPresentViewType_forgetPassword
};

@interface LoginAndRegisterViewController:UIViewController<presentViewDelegate>

@property (nonatomic,assign)CustomPresentViewType currentPresentViewType;
/**
 *  登录，注册操作后让个人页面刷新的回调
 */
@property (nonatomic,weak)id<PersonalViewControllerDelegate> delegate;

+(instancetype)shareInstance;

-(void)setDefaultViewType;
-(void)removeCurrentPresentView;
-(void)currentParentViewNormalConstraints;
@end
