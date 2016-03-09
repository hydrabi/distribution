//
//  User+CoreDataProperties.h
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)
/**
 *  头像地址
 */
@property (nullable, nonatomic, retain) NSString *headImage;
/**
 *  年龄
 */
@property (nullable, nonatomic, retain) NSString *age;
/**
 *  性别
 */
@property (nullable, nonatomic, retain) NSString *gender;
/**
 *  位置
 */
@property (nullable, nonatomic, retain) NSString *location;
/**
 *  电话（账号手机）
 */
@property (nullable, nonatomic, retain) NSString *telephone;
/**
 *  联系电话
 */
@property (nullable, nonatomic, retain) NSString *contactTelephone;
/**
 *  位置信息（用于初始化选择位置）
 */
@property (nullable, nonatomic, retain) NSMutableDictionary *locationDic;
/**
 *  收藏
 */
@property (nullable, nonatomic, retain) NSMutableArray *collectionArr;
/**
 *  密码，虽然无必要，但感觉环信会用到
 */
@property (nullable, nonatomic, retain) NSString *password;
@end

NS_ASSUME_NONNULL_END
