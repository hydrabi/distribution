//
//  CustomShare.m
//  Distribution
//
//  Created by Hydra on 16/1/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomShare.h"
#import "SGActionView.h"
#import "OpenShare.h"
#import "OpenShare+QQ.h"
#import "OpenShare+Weibo.h"
#import "OpenShare+Weixin.h"
#import "ImageManager.h"
#import "AppDelegate.h"
#import "UIAlertView+Addition.h"
@interface CustomShare()<UIAlertViewDelegate>
@property (nonatomic,strong)AVObject *object;
/**
 *  表示正在加载中
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;

@property (assign,nonatomic) CustomShareType selectShareIndex;

@property (strong,nonatomic) NSMutableArray *shareTypeArr;
@end

@implementation CustomShare

+(instancetype)shareManager{
    static CustomShare *customShare = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        customShare = [[CustomShare alloc] init];
    });
    return customShare;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.shareTypeArr = @[].mutableCopy;
    }
    return self;
}

-(MBProgressHUD*)progressHUD{
    if(!_progressHUD){
        RootViewController *vc = [AppDelegate getRootController];
        _progressHUD = [[MBProgressHUD alloc] initWithView:vc.view];
        _progressHUD.mode     = MBProgressHUDModeIndeterminate;
        
    }
    return _progressHUD;
}

-(void)showShareMenuWithObject:(AVObject*)object{
    self.object = object;
    
    NSMutableArray *titleArr = @[].mutableCopy;
    NSMutableArray *imageArr = @[].mutableCopy;
    [self.shareTypeArr removeAllObjects];
    //已经安装QQ客户端
    if([TencentOAuth iphoneQQInstalled]){
        [self.shareTypeArr addObject:@(CustomShareTypeQQ)];
        [titleArr addObject:TencentShareTitle];
        [imageArr addObject:[UIImage imageNamed:TencentShareImageName]];
    }
    //已经安装微信客户端
    if([WXApi isWXAppInstalled]){
        [self.shareTypeArr addObject:@(CustomShareTypeWeixin)];
        [titleArr addObject:WeiXinShareTitle];
        [imageArr addObject:[UIImage imageNamed:WeiXinShareImageName]];
    }
    //已经安装新浪客户端
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]){
        [self.shareTypeArr addObject:@(CustomShareTypeWeiBo)];
        [titleArr addObject:WeiBoShareTitle];
        [imageArr addObject:[UIImage imageNamed:WeiBoShareImageName]];
    }
    //已经安装支付宝客户端
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]){
        [self.shareTypeArr addObject:@(CustomShareTypeZhiFuBao)];
        [titleArr addObject:ZhiFuBaoShareTitle];
        [imageArr addObject:[UIImage imageNamed:ZhiFuBaoShareImageName]];
    }
    
    if(self.shareTypeArr.count>0){
        [SGActionView showGridMenuWithTitle:@"分享"
                                 itemTitles:titleArr
                                     images:imageArr
                             selectedHandle:^(NSInteger index){
                                 CustomShareType type = (CustomShareType)[self.shareTypeArr[index]integerValue];
                                 self.selectShareIndex = type;
                                 
//                                 NSString *desc = [[self.object objectForKey:@"localData"] objectForKey:@"productdesc"];
//                                 if(desc.length>0){
//                                     [UIPasteboard generalPasteboard].string = desc;
//                                 }
//                                 [self saveImagesToAlbumWithCompletion:^(BOOL success){
//                                     
//                                     [UIAlertView alertWithTitle:@"图片已经存入相册，描述已经复制到剪贴板，分享时可手动黏贴" delegate:self];
//                                 }];
                                 
                             }];
    }
    else{
        [MBProgressHUD showError:@"请安装微信/微博/QQ客户端"];
    }
    
}

-(void)saveImagesToAlbumWithCompletion:(void (^)(BOOL success))completion{
    NSDictionary *localData = [self.object objectForKey:@"localData"];
    self.progressHUD.labelText = @"图片保存中...";
    RootViewController *vc = [AppDelegate getRootController];
    [vc.view addSubview:self.progressHUD];
    [self.progressHUD show:YES];
    NSArray *imgs = [localData objectForKey:@"imgs"];
    [ImageManager createAlbumWithImgs:imgs completion:^(BOOL success){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressHUD hide:YES];
            completion(success);
        });
    }];
}

-(void)QQShare{
//    TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentAppId andDelegate:nil];
//    [tencentOAuth openSDKWebViewQQShareEnable];
//    NSLog(@"TencentOAuth accessToken:%@", tencentOAuth.accessToken);
//    
//    QQApiTextObject *textObj = [QQApiTextObject objectWithText:[[self.object objectForKey:@"localData"] objectForKey:@"productname"]];
//    
//    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:textObj];
//    
//    if (self.selectShareIndex == CustomShareTypeQQ) {
//        //将内容分享到qq
//        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//        NSLog(@"QQApiSendResultCode:%d", sent);
//        
//    }else{
//        //将内容分享到qzone
//        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
//        NSLog(@"Qzone QQApiSendResultCode:%d", sent);
//        
//    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqapi://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqqapi://"]];
    }
    else{
        [MBProgressHUD showError:@"未安装QQ客户端！"];
    }
}

-(void)weChatShare{
//    NSDictionary *localData = [self.object objectForKey:@"localData"];
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = [localData objectForKey:@"productname"];
//    message.description = [localData objectForKey:@"productdesc"];
//    
//    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = @"";
//    
//    message.mediaObject = ext;
//    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    if(self.selectShareIndex == CustomShareTypeWeixin){
//        req.scene = WXSceneSession;
//    }
//    else{
//        req.scene = WXSceneTimeline;
//    }
//    [WXApi sendReq:req];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    }
    else{
        [MBProgressHUD showError:@"未安装微信客户端！"];
    }
    
}

#pragma mark - 微博分享

-(void)weiboShare{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sinaweibo://"]];
    }
    else{
        [MBProgressHUD showError:@"未安装新浪微博客户端！"];
    }
    
    
}

#pragma mark - 支付宝分享
-(void)zhiFuBaoShare{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipay://"]];
    }
    else{
        [MBProgressHUD showError:@"未安装支付宝客户端！"];
    }
}

//- (void)shareToWeiboBase
//{
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = WeiboAppRedirectURL;
//    authRequest.scope = @"all";
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:nil];
//    
//    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    
//    [WeiboSDK sendRequest:request];
//}
//
//- (WBMessageObject *)messageToShare
//{
//    NSDictionary *localData = [self.object objectForKey:@"localData"];
////    NSString *utf8String = @"http://open.weibo.com";
//    NSString *theTitle = [localData objectForKey:@"productname"];
//    NSString *description = [localData objectForKey:@"productdesc"];
//    WBMessageObject *message = [WBMessageObject message];
//    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
//    
//    if(hadInstalledWeibo){
//        message.imageObject = [WBImageObject object];
////        message.imageObject.imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"CollectionViewCell_Test1"], 0.5);
//        message.text = [NSString stringWithFormat:@"%@,%@", theTitle, description];
//    }
//    else{
//        WBWebpageObject *webpage = [WBWebpageObject object];
//        webpage.objectID = @"identifier1";
//        webpage.title = theTitle;
//        webpage.description = description;
////        webpage.webpageUrl = utf8String;
//        message.mediaObject = webpage;
//    }
//    
//    return message;
//    
//}

#pragma mark - QQ回调协议 QQApiInterfaceDelegate
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{
    
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp{
    NSString *message;
    //qq回调
    if([resp isKindOfClass:[QQBaseResp class]]){
        QQBaseResp *qqResp = (QQBaseResp*)resp;
        if([qqResp.result integerValue] == 0) {
            message = @"分享成功";
        }else{
            message = @"分享失败";
        }
        NSLog(@"%@",message);
    }
    //微信回调
    else if ([resp isKindOfClass:[BaseResp class]]){
        BaseResp *weixinResp = (BaseResp*)resp;
        if(weixinResp.errCode == 0) {
            message = @"分享成功";
        }else{
            message = @"分享失败";
        }
        NSLog(@"%@",message);
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

#pragma mark - 微博回调
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *message;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            message = @"分享成功";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            message = @"取消分享";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            message = @"分享失败";
            break;
        default:
            message = @"分享失败";
            break;
    }
    NSLog(@"%@",message);
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 1){
//        switch (self.selectShareIndex) {
//            case CustomShareTypeQQ:
//            {
//                [self QQShare];
//            }
//                break;
//            case CustomShareTypeQQZone:
//            {
//                [self QQShare];
//            }
//                break;
//            case CustomShareTypeWeixin:
//            {
//                [self weChatShare];
//            }
//                break;
//            case CustomShareTypeWeixinFriends:
//            {
//                [self weChatShare];
//            }
//                break;
//            case CustomShareTypeWeiBo:
//            {
//                [self weiboShare];
//            }
//                break;
//            case CustomShareTypeZhiFuBao:
//            {
//                [self zhiFuBaoShare];
//            }
//                break;
//            default:
//                break;
//        }
//    }
//}

#pragma mark - 图片保存并分享到微信
-(void)saveImagesAndShareToWeiXin:(AVObject*)object{
    //已经安装微信
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
        self.object = object;
        [[CustomShare shareManager] saveImagesToAlbumWithCompletion:^(BOOL success){
            if(success){
                NSString *desc = [[self.object objectForKey:@"localData"] objectForKey:@"productdesc"];
                if(desc.length>0){
                    [UIPasteboard generalPasteboard].string = desc;
                }
                [UIAlertView alertWithTitle:@"图片已经存入相册，描述已经复制到剪贴板，分享时可手动黏贴" delegate:self];
            }
            else{
                [MBProgressHUD showError:@"图片保存失败！"];
            }
        }];
        
    }
    else{
        [MBProgressHUD showError:@"未安装微信客户端！"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
    }
}
@end
