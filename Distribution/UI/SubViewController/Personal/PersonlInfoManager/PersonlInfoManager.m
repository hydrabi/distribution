//
//  PersonlInfoManager.m
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonlInfoManager.h"
#import "AppDelegate.h"
#import "PersonalMacro.h"
#import "RequestData.h"
#define UserDefaultKey_PersonalTelephone @"UserDefaultKey_PersonalTelephone"
//重连时间
#define ReloginTimeInterval 60.0f
@interface PersonlInfoManager()
/**
 *  表示正在加载中
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;

@property (strong,nonatomic) NSTimer *reloginTimer;
@end

@implementation PersonlInfoManager

+(instancetype)shareManager{
    static PersonlInfoManager *personalInfo = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        personalInfo = [[PersonlInfoManager alloc] init];
    });
    return personalInfo;
}

-(MBProgressHUD*)progressHUD{
    if(!_progressHUD){
        RootViewController *vc = [AppDelegate getRootController];
        _progressHUD = [[MBProgressHUD alloc] initWithView:vc.view];
        _progressHUD.mode     = MBProgressHUDModeIndeterminate;

    }
    return _progressHUD;
}

-(void)dealloc{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - 属性
-(BOOL)hadLogin{
    AVUser *user = [AVUser currentUser];
    if(user){
        return YES;
    }
    else{
        return NO;
    }
}

-(NSString*)currentLoginPersonalTelephone{
    AVUser *user = [AVUser currentUser];
    if(user){
        return user.mobilePhoneNumber;
    }
    else{
        return nil;
    }
}

-(AVUser*)currentLoginUser{
    AVUser *user = [AVUser currentUser];
    if(user){
        return user;
    }
    else{
        return nil;
    }
    return nil;
}

#pragma mark - 登陆,外部使用
/**登陆准备*/
-(void)loginPrepare{
    self.progressHUD.labelText = @"正在登录...";
    RootViewController *vc = [AppDelegate getRootController];
    if(vc.presentedViewController){
        [vc.presentedViewController.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
    }
}

/**环信登录*/
-(BOOL)easeLoginWithTelephone:(NSString*)telephone password:(NSString*)password{
    BOOL success = NO;
    EMError *error = nil;
    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:telephone password:password error:&error];
//    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:telephone password:password error:&error];
    if(!error && loginInfo){
        //成功设置自动登录
        [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
        success = YES;
        NSLog(@"环信登录成功!");
    }
    else{
        success = NO;
        NSLog(@"环信登录失败!%@",error.description);
    }
    return success;
}

/**登陆请求*/
-(void)loginWithTelephoneNumber:(NSString*)telephone password:(NSString*)password completiton:(void(^)(BOOL success))block{
    if(telephone.length>0){
        [self loginPrepare];
        
        __weak typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL success = NO;
            //leanCloud登录
            success = [self leanCloudLoginWithTelephone:telephone password:password];
            AVUser *user = [AVUser currentUser];
            //如果leanCloud登录成功
            if(success){
                //环信登陆
                [self easeLoginWithTelephone:telephone password:user.easePassword];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf loginComplete:success telephoneNumber:telephone password:password];
                block(success);
            });
            
        });
        
        
    }
}

/**登陆结束*/
-(void)loginComplete:(BOOL)result telephoneNumber:(NSString*)telephone password:(NSString*)password {
    [self.progressHUD hide:YES];
    //登陆成功
    if(result){
        [[NSUserDefaults standardUserDefaults] setObject:telephone forKey:UserDefaultKey_PersonalTelephone];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginStatusChange object:nil];
    }
    //登陆失败，登出
    else{
        [self logoutWithBlock:^(BOOL success){
            
        }];
    }
}

#pragma mark - 失败重连
//如果几把远那边的注册接口失败，实际上那边是在不断重新尝试的，所以客户端这边每隔60秒重新登录，直至登录成功为止
-(void)easeReloginIfLoginFail{
    //是否已经登录
    BOOL easeHadLogin = [[EaseMob sharedInstance].chatManager isLoggedIn];
    //是否已经设置自动登录
    BOOL easeHadSetIsAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    AVUser *user = [AVUser currentUser];
    //环信是否已经注册成功
    BOOL hadRegisterSuccess = user.easeHadRegisterSuccess;
    if([self hadLogin] && !easeHadLogin && !easeHadSetIsAutoLogin && !hadRegisterSuccess){
        if(!self.reloginTimer){
            self.reloginTimer = [NSTimer scheduledTimerWithTimeInterval:ReloginTimeInterval target:self selector:@selector(loginFailRelogin) userInfo:nil repeats:YES];
            [self.reloginTimer fire];
        }
    }
}

-(void)loginFailRelogin{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL success = NO;
        //是否已经登录
        BOOL easeHadLogin = [[EaseMob sharedInstance].chatManager isLoggedIn];
        //是否已经设置自动登录
        BOOL easeHadSetIsAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
        AVUser *user = [AVUser currentUser];
        //环信是否已经注册成功
        BOOL hadRegisterSuccess = user.easeHadRegisterSuccess;
        if(!easeHadLogin && !easeHadSetIsAutoLogin && [self hadLogin] && !hadRegisterSuccess){
            success = [self easeLoginWithTelephone:user.username password:user.easePassword];
            if(success){
                user.easeHadRegisterSuccess = YES;
                [user saveEventually];
                [self.reloginTimer invalidate];
                self.reloginTimer=nil;
            }
        }
        else{
            [self.reloginTimer invalidate];
            self.reloginTimer=nil;
        }
    });
}

#pragma mark - 登出,外部使用
-(void)logoutPrepare{
    self.progressHUD.labelText = @"正在退出...";
    RootViewController *vc = [AppDelegate getRootController];
    if(vc.presentedViewController){
        [vc.presentedViewController.view addSubview:self.progressHUD];
    }
    else{
        [vc.view addSubview:self.progressHUD];
    }
    [self.progressHUD show:YES];
}

-(void)logoutWithBlock:(void(^)(BOOL success))block{
    
    //leanClound登出
    [AVUser logOut];
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL result = YES;
        EMError *error = nil;
        NSDictionary *info = [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:&error];
        if (!error && info) {
            NSLog(@"环信退出成功");
            result = YES;
        }
        else{
            NSLog(@"环信退出失败！,%@",error.description);
            result = NO;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf logoutCompleteWithResult:result];
            block(result);
        });
    });
}

/**登出完成*/
-(void)logoutCompleteWithResult:(BOOL)result{
    [self.progressHUD hide:YES];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserDefaultKey_PersonalTelephone];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginStatusChange object:nil];
}

#pragma mark - 注册,外部使用
/**环信注册*/
//-(BOOL)easeRegisterWithTelephone:(NSString*)telephone password:(NSString*)password{
//    BOOL success = NO;
//    //环信注册
//    EMError *error = nil;
//    [[EaseMob sharedInstance].chatManager registerNewAccount:telephone password:password error:&error];
//    if(!error){
//        success = YES;
//        NSLog(@"环信注册成功!");
//    }
//    else{
//        success = NO;
//        NSLog(@"环信注册失败!%@",error.description);
//    }
//    return success;
//}

/**注册准备*/
-(void)registerPrepare{
    self.progressHUD.labelText = @"正在注册...";
    RootViewController *vc = [AppDelegate getRootController];
    if(vc.presentedViewController){
        [vc.presentedViewController.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
    }
    
}

/**注册请求*/
-(void)registerWithTelephoneNumber:(NSString*)telephone password:(NSString*)password completiton:(void(^)(BOOL success))block{
    if(telephone.length>0){
        [self registerPrepare];
        
        __weak typeof(self)weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL success = NO;
            //leanCloud注册
            success = [self leanCloudRegisterWithTelephone:telephone password:password];
            //leanCloud注册成功
            if(success){
                AVUser *user = [AVUser currentUser];
                //保存环信密码,使用objectId作为环信登录密码
                user.easePassword = user.objectId;
                [user saveEventually];
                //leanCloud登陆成功后，注册就当作成功；
                dispatch_async(dispatch_get_main_queue(), ^{
                    //注册成功后,登陆也成功了，本地数据写入
                    [self loginComplete:YES telephoneNumber:telephone password:password];
                });
                //环信后台注册使用requestData类中的挤吧远提供的注册接口
                [self distributionRegisterWithTelephone:telephone password:user.objectId];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf registerComplete:success];
                block(success);
            });
            
        });
        
        
    }
}

/**注册结束*/
-(void)registerComplete:(BOOL)result {
    [self.progressHUD hide:YES];
    //注册成功
    if(result){
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginStatusChange object:nil];
    }
    //注册失败,登出
    else{
        [self logoutWithBlock:^(BOOL success){
            
        }];
    }
}

//环信后台注册使用requestData类中的挤吧远提供的注册接口
-(void)distributionRegisterWithTelephone:(NSString*)telephone password:(NSString*)password{
    [RequestData registerUserWithUserName:telephone password:password completiton:^(BOOL success){
        if(success){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                AVUser *user = [AVUser currentUser];
                user.easeHadRegisterSuccess = YES;
                //注册成功后环信登陆
                [self easeLoginWithTelephone:telephone password:user.easePassword];
                
            });
        }
        else{
            AVUser *user = [AVUser currentUser];
            user.easeHadRegisterSuccess = NO;
            [self easeReloginIfLoginFail];
        }
    }];
}

#pragma mark - IChatManagerDelegate 环信登录状态变化

- (void)didLoginFromOtherDevice
{
//    [MBProgressHUD showMessage:@"你的账号已在别处登录！"];
    NSLog(@"被踢！");
    [self logoutPrepare];
    //退出登录
    [self logoutWithBlock:^(BOOL success){
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginStatusChange object:nil];
    }];

}

- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error{
    if(!error){
        NSLog(@"环信自动登陆成功");
    }
    else{
        NSLog(@"环信自动登陆失败%@",error.description);
    }
}

#pragma mark - leanCloud注册
/***leanCloud注册*/
-(BOOL)leanCloudRegisterWithTelephone:(NSString*)telephone password:(NSString*)password{
    BOOL success = NO;
    NSError *error = nil;
    AVUser *user = [AVUser user];
    user.username = telephone;
    user.password =  password;
    user.mobilePhoneNumber = telephone;
    [user signUp:&error];
    if(!error){
        success = YES;
    }
    else{
        success = NO;
    }
    return success;
}

//获取注册验证码
-(void)leanCloudRequestVerifyCodeWithTelephone:(NSString*)telephone password:(NSString*)password completiton:(void(^)(BOOL success,NSError *error))block{
    
    [AVOSCloud requestSmsCodeWithPhoneNumber:telephone
                                     appName:@"分销平台"
                                   operation:@"注册"
                                  timeToLive:10
                                    callback:^(BOOL succeeded, NSError *error) {
                                        if (succeeded) {
                                            block(succeeded,error);
                                        }
                                    }];
}

//验证验证码
-(void)leanCloudVerifyVerifyCodeWith:(NSString*)verifyCode telephone:(NSString*)telephone completiton:(void(^)(BOOL success,NSError *error))block{
    [AVOSCloud verifySmsCode:verifyCode mobilePhoneNumber:telephone callback:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            //验证结果
            block(succeeded,error);
        }
    }];
}

#pragma mark - leanCloud登录
/**leanCloud登录*/
-(BOOL)leanCloudLoginWithTelephone:(NSString*)telephone password:(NSString*)password{
    NSError *error = nil;
    BOOL success = NO;
    [AVUser logInWithUsername:telephone password:password error:&error];
    if(!error){
        success = YES;
        NSLog(@"leanCloud登录成功");
    }
    else{
        success = NO;
        NSLog(@"leanCloud登录失败%@",error);
    }
    return success;
}

#pragma mark - leanCloud忘记密码
//获取忘记密码的验证码
-(void)leanCloudRequestForgetPasswordVerifyCodeWithTelephone:(NSString*)telephone completiton:(void(^)(BOOL success,NSError *error))block{
    
    [AVUser requestPasswordResetWithPhoneNumber:telephone block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"获取忘记密码的验证码成功！");
        } else {
            NSLog(@"获取忘记密码的验证码失败！");
        }
        block(succeeded,error);
    }];
}

//验证忘记密码的验证码
-(void)leanCloudVerifyForgetPasswordVerifyCodeWith:(NSString*)verifyCode telephone:(NSString*)telephone newPassword:(NSString*)newPassword completiton:(void(^)(BOOL success,NSError *error))block{
    [self resetPasswordPrepare];
    [AVUser resetPasswordWithSmsCode:verifyCode newPassword:newPassword block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"密码重置成功！");
        } else {
            NSLog(@"密码重置失败！");
        }
        block(succeeded,error);
        [self.progressHUD hide:YES];
    }];
}

/**注册准备*/
-(void)resetPasswordPrepare{
    self.progressHUD.labelText = @"重置中...";
    RootViewController *vc = [AppDelegate getRootController];
    if(vc.presentedViewController){
        [vc.presentedViewController.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
    }
    
}

#pragma mark - leanCloud 设置属性

//服务器数据同步到客户端，登陆后或者打开app有登录过的情况下使用
-(void)AVUserAttributeSynchronize:(void(^)(AVObject *object, NSError *error))block{
    AVUser *user = [AVUser currentUser];
    if(user){
        [user refreshInBackgroundWithBlock:^(AVObject *object, NSError *error){
            block(object,error);
        }];
    }
}
@end
