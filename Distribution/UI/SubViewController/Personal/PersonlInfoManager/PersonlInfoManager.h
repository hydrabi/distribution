//
//  PersonlInfoManager.h
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EaseUI.h"
#import "EMSDKFull.h"
#import "PersonlInfoMacro.h"
#import <AVOSCloud/AVOSCloud.h>

@interface PersonlInfoManager : NSObject<IChatManagerDelegate>

+(instancetype)shareManager;

#pragma mark - 用户属性
/**
 *  是否已经登录
 *
 *  @return 已经登录返回yes；未登录过或者已经退出了登录返回no
 */
-(BOOL)hadLogin;

/**
 *  上次登录的手机号码
 *
 *  @return 返回上次登录的手机号码
 */
-(NSString*)currentLoginPersonalTelephone;

#pragma mark - 登出
/**
 *  登出
 */
-(void)logoutWithBlock:(void(^)(BOOL success))block;

/**
 *  登出准备
 */
-(void)logoutPrepare;

#pragma mark - 登陆
/**
 *  以手机号码作为登录依据
 *
 *  @param telephone 手机号码
 *  @param password  密码
 *  @param block     回调 success 登陆成功返回yes，否则no
 */
-(void)loginWithTelephoneNumber:(NSString*)telephone password:(NSString*)password completiton:(void(^)(BOOL success))block;

#pragma mark - 注册
/**
 *  注册账号
 *
 *  @param telephone 手机号码
 *  @param password  密码
 *  @param block     回调 success 注册成功返回yes，否则no
 */
-(void)registerWithTelephoneNumber:(NSString*)telephone password:(NSString*)password completiton:(void(^)(BOOL success))block;

#pragma mark - leanCloud注册
//获取注册验证码
-(void)leanCloudRequestVerifyCodeWithTelephone:(NSString*)telephone password:(NSString*)password completiton:(void(^)(BOOL success,NSError *error))block;

//验证验证码
-(void)leanCloudVerifyVerifyCodeWith:(NSString*)verifyCode telephone:(NSString*)telephone completiton:(void(^)(BOOL success,NSError *error))block;

#pragma mark - leanCloud忘记密码
/**
 *  获取忘记密码的验证码
 *
 *  @param telephone 电话号码
 *  @param block     回调
 */
-(void)leanCloudRequestForgetPasswordVerifyCodeWithTelephone:(NSString*)telephone completiton:(void(^)(BOOL success,NSError *error))block;

/**
 *  验证忘记密码的验证码
 *
 *  @param verifyCode  验证码
 *  @param telephone   电话号码
 *  @param newPassword 新的密码
 *  @param block       回调
 */
-(void)leanCloudVerifyForgetPasswordVerifyCodeWith:(NSString*)verifyCode telephone:(NSString*)telephone newPassword:(NSString*)newPassword completiton:(void(^)(BOOL success,NSError *error))block;

#pragma mark - leanCloud 设置属性
/**
 *  同步user的属性
 */
-(void)AVUserAttributeSynchronize:(void(^)(AVObject *object, NSError *error))block;

#pragma mark - 失败重连
/**
 *  如果提供的注册接口注册失败，导致环信无法登陆，实际上服务器那边是在不断重新尝试的，所以客户端这边每隔60秒重新登录，直至登录成功为止

 */
-(void)easeReloginIfLoginFail;
@end
