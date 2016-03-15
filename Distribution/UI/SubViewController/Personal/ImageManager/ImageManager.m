//
//  ImageManager.m
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ImageManager.h"
#import "SDWebImageManager.h"
#import <AFNetworking/AFNetworking.h>
#import "RequestData.h"
@implementation ImageManager

+ (NSString *)imagePathInDocumentDirectory{
    //获取沙盒中的文档目录
//    NSString *homeDierectory = NSHomeDirectory();
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    NSString *imagePath = [documentDirectory stringByAppendingPathComponent:@"image"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:imagePath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imagePath;
}

+ (BOOL)saveImageToDisk:(UIImage*)image user:(AVUser*)user{
    NSData *imgData   = UIImageJPEGRepresentation(image, 0.5);
    NSString *name    = [[NSUUID UUID] UUIDString];
    NSString *jpgPath	  = [NSString stringWithFormat:@"%@/%@.jpg",[ImageManager imagePathInDocumentDirectory], name];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:jpgPath]){
        if ([imgData writeToFile:jpgPath atomically:YES]) {
            user.headImage = name;
        } else {
            
            return NO;
        }
    }
    
    return YES;
}

+ (void)deleteImageAtPath:(NSString *)path user:(AVUser*)user{
    NSError *error;
    NSString *jpgPath	  = [NSString stringWithFormat:@"%@/%@.jpg",[ImageManager imagePathInDocumentDirectory], user.headImage];
    [[NSFileManager defaultManager] removeItemAtPath:jpgPath error:&error];
}

+(UIImage*)userHeadImageWithImageName:(AVUser*)user{
    UIImage *image = [self userHeadDefaultImage];
    if(user){
        if(user.headImage.length>0){
            NSString *jpgPath	  = [NSString stringWithFormat:@"%@/%@.jpg",[ImageManager imagePathInDocumentDirectory], user.headImage];
            if([[NSFileManager defaultManager] fileExistsAtPath:jpgPath])
            {
                NSData *imgData = [NSData dataWithContentsOfFile:jpgPath];
                image = [UIImage imageWithData:imgData];
            }
        }
    }
    return image;
}

+(UIImage*)userHeadDefaultImage{
    UIImage *image = [UIImage imageNamed:@"personalNameCell_headDefault"];
    return image;
}

//照片访问权限
+(BOOL)haveAuthorizationOfPhoto{
    BOOL result = YES;
    if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0){
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if(status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusRestricted){
            return NO;
        }
    }
    else{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusRestricted) {
            return NO;
        }
    }
    return result;
}

//创建相册
+(void)createAlbumWithImgs:(NSArray<NSString*>*)imgs completion:(void (^)(BOOL success))completion{

    [RequestData downloadImages:imgs completiton:^(NSMutableArray *imagesArr){
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
            [ImageManager advancedCreateAlbumWithBlock:^(BOOL success){
                if(success){
                    [ImageManager advancedAddAssetsWithImage:imagesArr completion:^(BOOL success){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(success);
                        });
                        return;
                    }];
                }
                
            }];
        }
        else{
            [ImageManager backwardAddImageWithImage:imagesArr
                                          WithBlock:^(BOOL success){
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completion(success);
                                              });
                                          }];
        }
    }];
    

    
}

#pragma mark - ios8 以上创建相册
//iOS8以上创建相册
+(void)advancedCreateAlbumWithBlock:(void (^)(BOOL success))completion{
    
    BOOL isHaveAlbum = NO;
    if([ImageManager advancedGetMyAlbum]){
        isHaveAlbum = YES;
    }
    
    if(!isHaveAlbum){
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:Global_albumName];
        }completionHandler:^(BOOL success,NSError *error){
            completion(success);
            if(error){
                NSLog(@"创建相册失败，%@",error);
            }
        }];
    }
    else{
        completion(isHaveAlbum);
    }
}

//获取分销平台相册
+(PHAssetCollection*)advancedGetMyAlbum{
    PHFetchResult *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHAssetCollection *myAlbum = nil;
    PHAssetCollection *collection = nil;
    for (int i = 0; i < collections.count; i ++) {
        
        collection = collections[i];
        NSString *name = collection.localizedTitle;
        if([name isEqualToString:Global_albumName]){
            myAlbum = collection;
            return myAlbum;
        }
        NSLog(@"%@",name);
        
    }
    return myAlbum;
}

//iOS8以上添加图片到相册中
+(void)advancedAddAssetsWithImage:(NSArray*)images completion:(void (^)(BOOL success))completion{
    PHAssetCollection *myAlbum = [ImageManager advancedGetMyAlbum];
    if(myAlbum && images.count>0){
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            NSMutableArray *arr = @[].mutableCopy;
            for(UIImage *image in images){
                PHObjectPlaceholder *holder = [[PHAssetChangeRequest creationRequestForAssetFromImage:image] placeholderForCreatedAsset];
                if(holder){
                    [arr addObject:holder];
                }
            }
            
            if(arr.count>0){
                PHAssetCollectionChangeRequest* collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:myAlbum];
                [collectionRequest addAssets:arr];
            }
            
        }
                                          completionHandler:^(BOOL success,NSError *error){
                                              completion(success);
                                              if(error){
                                                  NSLog(@"添加照片失败，%@",error);
                                              }
                                          }];
    }
    else{
        completion(NO);
    }
    
}

//删除所有相册里面的照片，没有用到。。
+(void)advancedDeleteAllAssets:(void (^)(BOOL success))completion{
    PHAssetCollection *myAlbum = [ImageManager advancedGetMyAlbum];
    PHFetchResult *assestResult = [PHAsset fetchAssetsInAssetCollection:myAlbum options:[PHFetchOptions new]];
    NSArray *assessArr = [assestResult objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, assestResult.count)]];
    if(assessArr.count>0){
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest deleteAssets:assessArr];
        }completionHandler:^(BOOL success,NSError *error){
            completion(success);
            if(error){
                NSLog(@"删除所有照片失败 %@",error);
            }
        }];
        
    }
    else{
        completion(YES);
    }
    
}

#pragma mark - ios8以下创建相册
//ios8以下创建相册
//+(void)backwardCreateAlbumWithBlock:(void (^)(BOOL success,ALAssetsGroup *group))completion{
//    ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
//    __block BOOL isHaveAlbum = NO;
//    [assetslibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group,BOOL *stop){
//        
//        if([Global_albumName compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame){
//            isHaveAlbum = YES;
//            completion(YES,group);
//            return ;
//        }
//        
//        //之前未创建的，创建分销平台的相册，存放图片
//        if(group == nil && !isHaveAlbum){
//            [assetslibrary addAssetsGroupAlbumWithName:Global_albumName
//                                           resultBlock:^(ALAssetsGroup *group){
//                                               completion(YES,group);
//                                           }
//                                          failureBlock:^(NSError *error){
//                                              completion(NO,group);
//                                          }];
//            isHaveAlbum = YES;
//            return;
//        }
//        
//    }failureBlock:^(NSError *error){
//        completion(NO,nil);
//    }];
//}
//
//+(void)backwardAddAssetsImageToAlbum:(NSString*)albumName image:(UIImage*)image ALAssetsGroup:(ALAssetsGroup *)group{
//    ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
//    [assetslibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL* assetURL, NSError* error)
//     {
//         if (error!=nil) {
//             return;
//         }
//         
//         [assetslibrary assetForURL: assetURL resultBlock:^(ALAsset *asset)
//          {
//              [group addAsset: asset];
//              
//          } failureBlock: nil];
//         
//     }];
//}


+(void)backwardAddImageWithImage:(NSArray*)images WithBlock:(void (^)(BOOL success))completion{
    dispatch_apply(images.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i){
        UIImage *image = images[i];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        if(i == images.count-1){
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
        }
    });
}

@end
