//
//  AVUser+Addition.m
//  Distribution
//
//  Created by Hydra on 16/1/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "AVUser+Attibute.h"
#import "PersonalMacro.h"
@implementation AVUser(Attibute)

#pragma mark - 头像
-(NSString*)headImage{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *head = user[AVUserKey_head];
        return head;
    }
    else {
        return nil;
    }
}

-(void)setHeadImage:(NSString *)headImage{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && headImage!=nil){
        [user setObject:headImage forKey:AVUserKey_head];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者头像为空！");
    }
}

#pragma mark - 年龄
-(NSString*)age{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *age = user[AVUserKey_age];
        return age;
    }
    else {
        return nil;
    }
}

-(void)setAge:(NSString *)age{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && age!=nil){
        [user setObject:age forKey:AVUserKey_age];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者年龄为空！");
    }
}

#pragma mark - 性别
-(NSString*)gender{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *gender = user[AVUserKey_gender];
        return gender;
    }
    else {
        return nil;
    }
}

-(void)setGender:(NSString *)gender{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && gender!=nil){
        [user setObject:gender forKey:AVUserKey_gender];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者性别为空！");
    }
}

#pragma mark - 位置
-(NSString*)location{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *location = user[AVUserKey_location];
        return location;
    }
    else {
        return nil;
    }
}

-(void)setLocation:(NSString *)location{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && location!=nil){
        [user setObject:location forKey:AVUserKey_location];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者位置为空！");
    }
}

-(NSMutableDictionary*)locationDic{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSMutableDictionary *locationDic = user[AVUserKey_locationDic];
        return locationDic;
    }
    else {
        return nil;
    }
}

-(void)setLocationDic:(NSMutableDictionary *)locationDic{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && locationDic!=nil){
        [user setObject:locationDic forKey:AVUserKey_locationDic];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者位置信息为空！");
    }
}

#pragma mark - 联系电话
-(NSString*)contactTelephone{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *contactTelephone = user[AVUserKey_contantPhone];
        return contactTelephone;
    }
    else {
        return nil;
    }
}

-(void)setContactTelephone:(NSString *)contactTelephone{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && contactTelephone!=nil){
        [user setObject:contactTelephone forKey:AVUserKey_contantPhone];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者联系电话为空！");
    }
}

#pragma mark - 环信密码
-(NSString *)easePassword{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *easePassword = user[AVUserKey_easePassword];
        return easePassword;
    }
    else{
        return nil;
    }
}

-(void)setEasePassword:(NSString *)easePassword{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && easePassword!=nil){
        [user setObject:easePassword forKey:AVUserKey_easePassword];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者环信密码为空！");
    }
}

#pragma mark - 环信注册已经成功
-(BOOL)easeHadRegisterSuccess{
    AVUser *user = [AVUser currentUser];
    if(user){
        BOOL hadRegisger = [user[AVUserKey_easeHadRegisterSuccess] boolValue];
        return hadRegisger;
    }
    else{
        return NO;
    }
}

-(void)setEaseHadRegisterSuccess:(BOOL)hadRegisterSuccess{
    AVUser *user = [AVUser currentUser];
    if(user!=nil){
        [user setObject:@(hadRegisterSuccess) forKey:AVUserKey_easeHadRegisterSuccess];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录！");
    }
}

#pragma mark - 收藏
-(void)addFavoriteWithObjectId:(AVObject*)object{
    
    AVUser *user = [AVUser currentUser];
    if(user!=nil && object.objectId.length>0){
        [object incrementKey:Global_ProductCollectNumber];
        [object saveInBackground];
        [user addObject:object.objectId forKey:AVUserKey_favorite];
        [user saveEventually];
    }
    else{
        NSLog(@"添加收藏失败");
    }
}

-(void)removeFavoriteWithObjectId:(AVObject*)object{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && object.objectId.length>0){
        [object incrementKey:Global_ProductCollectNumber byAmount:@(-1)];
        [object saveInBackground];
        [user removeObject:object.objectId forKey:AVUserKey_favorite];
        [user saveEventually];
    }
    else{
        NSLog(@"删除收藏失败");
    }
}

-(BOOL)containFavoriteObjectId:(NSString*)objectId{
    BOOL result = NO;
    AVUser *user = [AVUser currentUser];
    if(user!=nil && objectId.length>0){
        NSArray *arr = user[AVUserKey_favorite];
        if([arr containsObject:objectId]){
            result = YES;
        }
    }
    else{
        NSLog(@"获取是否收藏失败");
    }
    return result;
}

-(NSArray *)getAllFavoriteObjectId{
    NSArray *arr = nil;
    AVUser *user = [AVUser currentUser];
    if(user!=nil){
        arr = user[AVUserKey_favorite];
    }
    else{
        NSLog(@"当前未登录");
    }
    return arr;
}

#pragma mark - 昵称
-(NSString*)nickname{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *nickname = user[AVUserKey_nickname];
        return nickname;
    }
    else {
        return nil;
    }
}

-(void)setNickname:(NSString *)nickname{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && nickname!=nil){
        [user setObject:nickname forKey:AVUserKey_nickname];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者昵称为空！");
    }
}

#pragma mark - 个性签名
-(NSString*)signature{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *signature = user[AVUserKey_signature];
        return signature;
    }
    else {
        return nil;
    }
}

-(void)setSignature:(NSString *)signature{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && signature!=nil){
        [user setObject:signature forKey:AVUserKey_signature];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者签名为空！");
    }
}

#pragma mark - 微信
-(NSString*)weixin{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *weixin = user[AVUserKey_weixin];
        return weixin;
    }
    else {
        return nil;
    }
}

-(void)setWeixin:(NSString*)weixin{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && weixin!=nil){
        [user setObject:weixin forKey:AVUserKey_weixin];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者微信为空！");
    }
}

#pragma mark - qq
-(NSString*)qq{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *qq = user[AVUserKey_qq];
        return qq;
    }
    else {
        return nil;
    }
}

-(void)setQq:(NSString*)qq{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && qq!=nil){
        [user setObject:qq forKey:AVUserKey_qq];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者qq为空！");
    }
}

#pragma mark - 地址管理
-(NSMutableDictionary*)detailedAddress{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSMutableDictionary *adress = user[AVUserKey_manageAdress];
        return adress;
    }
    else {
        return nil;
    }
}

-(void)setDetailedAddress:(NSMutableDictionary*)address{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && address!=nil){
        [user setObject:address forKey:AVUserKey_manageAdress];
        [user saveEventually];
    }
    else{
        NSLog(@"当前未登录或者地址为空！");
    }
}

#pragma mark - 我的足迹
-(void)addTraceWithObject:(AVObject*)object{
    AVUser *user = [AVUser currentUser];
    if(user!=nil && object.objectId.length>0){
        NSArray *arr = user[AVUserKey_trace];
        if([arr containsObject:object.objectId]){
            NSMutableArray *tempArr = arr.mutableCopy;
            [tempArr removeObject:object.objectId];
            [tempArr addObject:object.objectId];
            [user setObject:tempArr forKey:AVUserKey_trace];
            [user saveInBackground];
        }
        else{
            [user addObject:object.objectId forKey:AVUserKey_trace];
            [user saveInBackground];
        }
    }
    else{
        NSLog(@"添加我的足迹失败");
    }
}

-(void)removeTraceWithObject:(AVObject*)object{
    AVUser *user = [AVUser currentUser];
    if(!user && !object){
        [user removeObject:object.objectId forKey:AVUserKey_trace];
        [user saveEventually];
    }
    else{
        NSLog(@"删除我的足迹失败");
    }
}

-(NSArray *)getAllTraceObject{
    NSArray *arr = nil;
    AVUser *user = [AVUser currentUser];
    if(user!=nil){
        arr = user[AVUserKey_trace];
        if(arr.count>0){
            arr = [[arr reverseObjectEnumerator] allObjects];
        }
    }
    else{
        NSLog(@"当前未登录");
    }
    return arr;
}
@end
