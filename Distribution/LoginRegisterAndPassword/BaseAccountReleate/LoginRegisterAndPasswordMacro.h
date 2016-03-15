//
//  LoginRegisterAndPasswordMacro.h
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#ifndef LoginRegisterAndPasswordMacro_h
#define LoginRegisterAndPasswordMacro_h
typedef NS_ENUM(NSInteger, AccountReleateViewControllerType) {
    AccountReleateViewControllerType_Login,             //登录
    AccountReleateViewControllerType_RegisterFirst,     //注册第一步
    AccountReleateViewControllerType_RegisterSecond,    //注册第二部
    AccountReleateViewControllerType_forgetPassword     //忘记密码
};

#define BaseAccountTableViewCellHeight 44.0f
#define BaseAccountTableViewHeaderHeight 50.0f
#define BaseAccountTableViewFooterHeight 80.0f

#endif /* LoginRegisterAndPasswordMacro_h */
