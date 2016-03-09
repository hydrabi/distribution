//
//  RequestData.h
//  Distribution
//
//  Created by Hydra on 16/1/19.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,productType) {
    productType_new = 1,            //上新
    productType_special,            //特批
    productType_all,                //全部
    productType_forwardSale,        //预售
    productType_overcoat,           //大衣
    productType_trousers,           //裤子
    productType_dress,              //连衣裙
    productType_sweater,            //毛衣
};

//每一页的商品数目
#define eachPageSize 9

@interface RequestData : NSObject

/**
 *  查询商品
 *
 *  @param type  商品类型枚举
 *  @param page  拖过的条数
 *  @param size  每条显示的条数
 *  @param block 回调block
 */
+(void)queryProductWithType:(productType)type skinSize:(NSInteger)skinSize size:(NSInteger)size completiton:(void (^)(NSArray *arr,NSError *err))block;


/**
 *  查询收藏
 *
 *  @param block 收藏回调
 */
+(void)queryFavoriteObjectWithCompletiton:(void (^)(NSArray *arr,NSError *error))block;

/**
 *  查询足迹
 *
 *  @param block 足迹回调
 */
+(void)queryTraceObjectWithCompletiton:(void (^) (NSArray *arr,NSError *error))block;

/**
 *  用户注册
 *
 *  @param userName 用户名（即手机号码）
 *  @param password 密码
 *  @param block    回调函数
 *
 *  @return 任务session
 */
+(NSURLSessionDataTask*)registerUserWithUserName:(NSString*)userName password:(NSString*)password completiton:(void (^)(BOOL success))block;

/**
 *  下载多张图片
 *
 *  @param images      图片的路径
 *  @param completiton 完成回调，返回下载成功的图片
 */
+(void)downloadImages:(NSArray<NSString *>*)images completiton:(void(^)(NSMutableArray* imageStoreArr))completiton;

/**
 *  使用搜索查找商品
 *
 *  @param searchStr 搜索框的关键词
 *  @param block     回调函数
 *
 *  @return AVQuery返回，用于取消查询
 */
+(AVQuery*)queryProductWithSearchBarText:(NSString *)searchStr completion:(void (^) (NSArray *arr,NSError *error))block;
@end
