//
//  AVUser+Addition.h
//  Distribution
//
//  Created by Hydra on 16/1/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
/**
 *  AVUser类的属性扩展
 */
@interface AVUser(Attibute)

#pragma mark - 头像
-(NSString*)headImage;

-(void)setHeadImage:(NSString *)headImage;

#pragma mark - 年龄
-(NSString*)age;

-(void)setAge:(NSString *)age;

#pragma mark - 性别
-(NSString*)gender;

-(void)setGender:(NSString *)gender;

#pragma mark - 位置
-(NSString*)location;

-(void)setLocation:(NSString *)location;

-(NSMutableDictionary*)locationDic;

-(void)setLocationDic:(NSMutableDictionary *)locationDic;

#pragma mark - 联系电话
-(NSString*)contactTelephone;

-(void)setContactTelephone:(NSString *)contactTelephone;

#pragma mark - 环信密码
-(NSString *)easePassword;

-(void)setEasePassword:(NSString *)easePassword;

#pragma mark - 环信注册已经成功
-(BOOL)easeHadRegisterSuccess;

-(void)setEaseHadRegisterSuccess:(BOOL)hadRegisterSuccess;

#pragma mark - 收藏
/**
 *  添加收藏
 *
 *  @param objectId 商品id
 */
-(void)addFavoriteWithObjectId:(AVObject*)object;
/**
 *  移除收藏
 *
 *  @param objectId 商品id
 */
-(void)removeFavoriteWithObjectId:(AVObject*)object;
/**
 *  收藏中是否已经包含某商品
 *
 *  @param objectId 商品id
 *
 *  @return yes，已包含；no，未包含
 */
-(BOOL)containFavoriteObjectId:(NSString*)objectId;
/**
 *  获取所有收藏商品id
 *
 *  @return 所有已收藏商品id的队列
 */
-(NSArray *)getAllFavoriteObjectId;

#pragma mark - 昵称
-(NSString*)nickname;

-(void)setNickname:(NSString *)nickname;

#pragma mark - 个性签名
-(NSString*)signature;

-(void)setSignature:(NSString *)signature;

#pragma mark - 微信
-(NSString*)weixin;

-(void)setWeixin:(NSString*)weixin;

#pragma mark - qq
-(NSString*)qq;

-(void)setQq:(NSString*)qq;

#pragma mark - 地址管理


#pragma mark - 我的足迹
/**
 *  添加足迹
 *
 *  @param object 浏览过的商品
 */
-(void)addTraceWithObject:(AVObject*)object;

/**
 *  删除足迹
 *
 *  @param object 需要删除的商品object
 */
-(void)removeTraceWithObject:(AVObject*)object;

/**
 *  获取所有足迹
 *
 *  @return 所有足迹的列表
 */
-(NSArray *)getAllTraceObject;

#pragma mark - 地址管理
/**
 *  添加新的收货地址
 *
 *  @param dic 收货地址信息
 */
-(void)addAddressWithDic:(NSMutableDictionary*)dic;

/**
 *  删除收货地址
 *
 *  @param dic 收货地址信息
 */
-(void)removeAddressWithDic:(NSDictionary*)dic;

/**
 *  修改收货地址
 *
 *  @param dic   收货地址信息
 *  @param index 收货地址处于收货地址列表的索引
 */
-(void)modifyAddressWithDic:(NSMutableDictionary*)dic index:(NSInteger)index;

/**
 *  设置为默认地址
 *
 *  @param dic 收货地址信息
 */
-(void)makeDefaultAddressWithDic:(NSDictionary*)dic completition:(void (^)(BOOL success,NSError *error))completition;
@end
