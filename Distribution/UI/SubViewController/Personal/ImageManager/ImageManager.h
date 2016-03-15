//
//  ImageManager.h
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface ImageManager : NSObject
+ (NSString *)imagePathInDocumentDirectory;
+ (BOOL)saveImageToDisk:(UIImage*)image user:(AVUser*)user;
+ (void)deleteImageAtPath:(NSString *)path user:(AVUser*)user;

/**
 *  用户头像图片
 *
 *  @param user 当前用户
 *
 *  @return 返回用户头像image
 */
+(UIImage*)userHeadImageWithImageName:(AVUser*)user;

/**
 *  用户默认头像
 *
 *  @return 返回用户默认头像
 */
+(UIImage*)userHeadDefaultImage;

/**
 *  是否拥有照片访问权限
 *
 *  @return yes，有；no，没有
 */
+(BOOL)haveAuthorizationOfPhoto;

/**
 *  创建相册并下载图片存入相册
 *
 *  @param completion 创建成功，回调yes，否则no
 */
+(void)createAlbumWithImgs:(NSArray<NSString*>*)imgs completion:(void (^)(BOOL success))completion;
@end
