//
//  CustomShare.h
//  Distribution
//
//  Created by Hydra on 16/1/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
#import "CustomShareMacro.h"

typedef NS_ENUM(NSInteger,CustomShareType) {
    CustomShareTypeQQ,                  //qq好友
    CustomShareTypeQQZone,              //qq空间
    CustomShareTypeWeixin,              //微信好友
    CustomShareTypeWeixinFriends,       //微信朋友圈
    CustomShareTypeWeiBo,               //新浪微博
    CustomShareTypeZhiFuBao,            //支付宝
    CustomShareTypeZhiFuBaoHome,        //支付宝生活圈
};

@interface CustomShare : NSObject<QQApiInterfaceDelegate,WXApiDelegate,WeiboSDKDelegate>

+(instancetype)shareManager;
-(void)showShareMenuWithObject:(AVObject*)object;
-(void)saveImagesAndShareToWeiXin:(AVObject*)object;
-(void)saveImages:(NSArray *)imgs completiton:(void (^)(BOOL success))completion;
@end
