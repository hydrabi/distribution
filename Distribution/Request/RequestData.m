//
//  RequestData.m
//  Distribution
//
//  Created by Hydra on 16/1/19.
//  Copyright © 2016年 distribution. All rights reserved.
//
#define AppId @"9dibcmhsV9QeOFoiWBaQmpbS-gzGzoHsz"
#define AppKey @"B2M1IKGroclg7SIO9X3CSood"
//超时时间
#define timeoutVal 30.0f

#define downLoadTimeOutVal 15.0f
//host
#define urlHost @"http://112.74.200.180:8080"
//查询商品
#define productLocation @"/distribution/queryProduct"
//查询商品详情
#define productDetailLocation @"/distribution/queryProductDetail"
//注册
#define registerUserLocation @"/distribution/registerUser"


#import "RequestData.h"
#import "MyMD5.h"
@implementation RequestData
/**创建token*/
+(NSString*)getToken{
    //D5A0B91B4A87A7DFD23469D9CE7861AF$456464212
    NSDate* nowDate = [NSDate date];
    NSTimeInterval a=[nowDate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    NSString *tokenStr = [NSString stringWithFormat:@"%@%@",AppId,AppKey];
    NSString *md5Str = [NSString stringWithFormat:@"%@$%@",[MyMD5 md5:tokenStr],timeString];
    return md5Str;
}

/**请求基础配置*/
+(NSURLSessionDataTask*)baseQueryWithUrlStr:(NSString*)urlStr body:(NSDictionary*)bodyDic completiton:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completiton{
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:timeoutVal];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[RequestData getToken] forHTTPHeaderField:@"token"];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:bodyDic options:0 error:&error];
    [request setHTTPBody:postData];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            completiton(data,response,error);
        });
        
    }];
    [postDataTask resume];
    return postDataTask;
}

+(NSURLSessionDataTask*)registerUserWithUserName:(NSString*)userName password:(NSString*)password completiton:(void (^)(BOOL success))block{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",urlHost,registerUserLocation];
    NSDictionary *bodyDic = @{@"username":userName,
                              @"password":password};
    return [RequestData baseQueryWithUrlStr:strUrl body:bodyDic completiton:^(NSData *data, NSURLResponse *response, NSError *error){
        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
        NSInteger code = res.statusCode;
        if(!error && data){
            NSString *resutl = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"注册成功，结果：%@",resutl);
            
            block(YES);
        }
        else{
            NSLog(@"注册失败，错误：%@",error);
            block(NO);
        }
    }];
}

#pragma mark - 下载图片
//下载多张图片
+(void)downloadImages:(NSArray<NSString *>*)imageUrls completiton:(void(^)(NSMutableArray* imageStoreArr))completiton{
    dispatch_group_t group = dispatch_group_create();
    __block NSMutableArray *imageStoreArr = @[].mutableCopy;
    for(int i = 0;i<imageUrls.count;i++){
        dispatch_group_enter(group);
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrls[i]]cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:downLoadTimeOutVal];
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//            if(data){
//                UIImage *image = [UIImage imageWithData:data];
//                if(image){
//                    [imageStoreArr addObject:image];
//                }
//            }
//            
//            dispatch_group_leave(group);
//        }];
//        [dataTask resume];
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrls[i]]
                                                              options:SDWebImageDownloaderUseNSURLCache
                                                             progress:^(NSInteger receivedSize, NSInteger expectedSize){
            
        }completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
            if(image){
                [imageStoreArr addObject:image];
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completiton(imageStoreArr);
    });
}

#pragma mark - 使用leanCloud查询功能
//查询商品
+(void)queryProductWithType:(productType)type skinSize:(NSInteger)skinSize size:(NSInteger)size completiton:(void (^)(NSArray *arr,NSError *error))block{

    AVQuery *query = [AVQuery queryWithClassName:@"Product"];
    if(type != productType_all){
        [query whereKey:@"type" equalTo:@(type)];
    }
    query.skip = skinSize;
    query.limit = size;
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *arr,NSError *error){
        block(arr,error);
    }];
}

//查询收藏
+(void)queryFavoriteObjectWithCompletiton:(void (^)(NSArray *arr,NSError *error))block{
    AVUser *user = [AVUser currentUser];
    if(user){
        AVQuery *query = [AVQuery queryWithClassName:@"Product"];
        NSArray *arr = [user getAllFavoriteObjectId];
        if(arr.count>0){
            [query whereKey:@"objectId" containedIn:arr];
            [query findObjectsInBackgroundWithBlock:^(NSArray *arr,NSError *error){
                block(arr,error);
            }];
        }
        else{
            block(nil,nil);
        }
        
    }
}

//查询足迹
+(void)queryTraceObjectWithCompletiton:(void (^) (NSArray *arr,NSError *error))block{
    AVUser *user = [AVUser currentUser];
    if(user){
        AVQuery *query = [AVQuery queryWithClassName:@"Product"];
        NSArray *arr = [user getAllTraceObject];
        if(arr.count>0){
            [query whereKey:@"objectId" containedIn:arr];
            [query findObjectsInBackgroundWithBlock:^(NSArray *resultArr,NSError *error){
                NSMutableArray *traceArr = @[].mutableCopy;
                for(int i = 0 ;i<arr.count;i++){
                    NSString *objectId = arr[i];
                    for(AVObject *object in resultArr){
                        if([objectId isEqualToString:object.objectId]){
                            [traceArr addObject:object];
                            break;
                        }
                    }
                }
                block(traceArr,error);
            }];
        }
        else{
            block(nil,nil);
        }
    }
}

+(AVQuery*)queryProductWithSearchBarText:(NSString *)searchStr completion:(void (^) (NSArray *arr,NSError *error))block{
    AVQuery *productNameQuery = [AVQuery queryWithClassName:@"Product"];
    [productNameQuery whereKey:@"productname" containsString:searchStr];
    
    AVQuery *productNumberQuery = [AVQuery queryWithClassName:@"Product"];
    [productNumberQuery whereKey:@"productnumber" containsString:searchStr];
    
    AVQuery *searchBarQuery = [AVQuery orQueryWithSubqueries:@[productNumberQuery,productNameQuery]];
    [searchBarQuery findObjectsInBackgroundWithBlock:^(NSArray *results,NSError *error){
        block(results,error);
    }];
    
    return searchBarQuery;
}

@end
