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

typedef NS_ENUM(NSInteger,AccountReleateCellType) {
    AccountReleateCellType_loginAccount,                //登录账号
    AccountReleateCellType_loginPassword,               //登录密码
    AccountReleateCellType_forgetPasswordTelephone,     //忘记密码手机号码
    AccountReleateCellType_forgetPasswordVerifyButton,  //验证码
    AccountReleateCellType_forgetPasswordNewPassword,   //新密码
    AccountReleateCellType_registerTelephone,           //注册手机号
    AccountReleateCellType_registerVerifyButton,        //注册验证码
    AccountReleateCellType_registerSettingPassword,     //注册密码设置
};

#define BaseAccountTableViewCellHeight 50.0f
#define BaseAccountTableViewHeaderHeight 60.0f
#define BaseAccountTableViewFooterHeight 100.0f

#endif /* LoginRegisterAndPasswordMacro_h */
