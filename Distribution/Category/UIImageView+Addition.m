//
//  UIImageView+Addition.m
//  Distribution
//
//  Created by Hydra on 16/3/8.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "UIImageView+Addition.h"
#import "Reachability.h"
#import "PersonalSettingFunctionMacro.h"
@implementation UIImageView(Addition)

-(void)downloadImageWithUrl:(NSString*)imageURL{
    
    
    Reachability* reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus statu=[reach currentReachabilityStatus];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultKey_PersonalSettingFunctionSetingWifiShowImage] boolValue]){
        //非wifi情况下
        if(statu!=ReachableViaWiFi){
            //缓存中没有该图片
            UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
            if(!cacheImage){
                [self setImage:[UIImage imageNamed:@"CommodityDefault"]];
                
            }
            else{
                [self setImage:cacheImage];
            }
            return;
        }
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL]
            placeholderImage:[UIImage imageNamed:@"CommodityDefault"]
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                      
                   }];
    
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [self setImage:[UIImage imageNamed:@"CommodityDefault"]];
//    [manager downloadImageWithURL:[NSURL URLWithString:imageURL]
//                          options:0
//                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                             
//                         }
//                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                            if (image) {
//                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                                    [self compressImage:image];
//                                });
//                            }
//                        }];
}

//压缩图片尺寸 骂了隔壁 还要自己压缩 不压缩内存爆灯了 艹
-(void)compressImage:(UIImage*)sourceImage{
    
//    NSData *imageData = UIImageJPEGRepresentation(originImage, 0.00001);
//    
//    UIImage *sourceImage = [UIImage imageWithData:imageData];
//    CGSize tempSize = sourceImage.size;
    __block UIImage *newImage         = nil;
    CGFloat screenScale       = [UIScreen mainScreen].scale;
    CGSize newSize            = CGSizeMake(CGRectGetWidth(self.frame)*screenScale, CGRectGetHeight(self.frame)*screenScale);
    CGFloat sourceWidth       = sourceImage.size.width;
    CGFloat sourceHeight      = sourceImage.size.height;
    CGFloat targetWidth       = newSize.width;
    CGFloat targetHeight      = newSize.height;
    CGFloat scaleFactor       = 0.0;
    CGFloat scaledWidth       = targetWidth;
    CGFloat scaledHeight      = targetHeight;
    CGPoint thumbnailPoint    = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(sourceImage.size, newSize) == NO){
        CGFloat widthFactor  = targetWidth / sourceWidth;
        CGFloat heightFactor = targetHeight / sourceHeight;
        if(widthFactor > heightFactor){
            scaleFactor          = widthFactor;
        }
        else{
            scaleFactor          = heightFactor;
        }
        scaledWidth          = sourceWidth * scaleFactor;
        scaledHeight         = sourceHeight * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y     = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x     = (targetWidth - scaledWidth) * 0.5;
        }
    }

    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContext(newSize);
        
        CGRect thumbnailRect      = CGRectZero;
        thumbnailRect.origin      = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage                  = UIGraphicsGetImageFromCurrentImageContext();
        if(newImage){
            [self setImage:newImage];
        }
        else{
            [self setImage:[UIImage imageNamed:@"CommodityDefault"]];
        }
//        CGImageRelease(newImage);
        UIGraphicsEndImageContext();
    });
    
    

    

//    return newImage;
}

//+ (UIImage *)makeResizedImage: (UIImage *)img withSize:(CGSize)newSize;
//{
//    // img = [VScanEngine _rotateImage:img];
//    //img= nil;
//    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
//    CGImageRef imageRef = img.CGImage;
//    
//    // Compute the bytes per row of the new image
//    size_t bytesPerRow = CGImageGetBitsPerPixel(imageRef) / CGImageGetBitsPerComponent(imageRef) * newRect.size.width;
//    bytesPerRow = (bytesPerRow + 15) & ~15;  // Make it 16-byte aligned
//    
//    // Build a bitmap context that's the same dimensions as the new size
//    CGContextRef bitmap = CGBitmapContextCreate(NULL,
//                                                newRect.size.width,
//                                                newRect.size.height,
//                                                CGImageGetBitsPerComponent(imageRef),
//                                                bytesPerRow,
//                                                CGImageGetColorSpace(imageRef),
//                                                CGImageGetBitmapInfo(imageRef));
//    
//    CGContextSetInterpolationQuality(bitmap, kCGInterpolationLow);
//    
//    // Draw into the context; this scales the image
//    CGContextDrawImage(bitmap, newRect, imageRef);
//    
//    // Get the resized image from the context and a UIImage
//    CGImageRef resizedImageRef = CGBitmapContextCreateImage(bitmap);
//    UIImage *resizedImage = [UIImage imageWithCGImage:resizedImageRef];
//    
//    // Clean up
//    CGContextRelease(bitmap);
//    CGImageRelease(resizedImageRef);
//    img= nil;
//    return resizedImage;
//}

@end
