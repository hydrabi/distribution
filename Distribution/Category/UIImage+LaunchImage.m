//
//  UIImage+LaunchImage.m
//  Distribution
//
//  Created by Hydra on 16/3/20.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "UIImage+LaunchImage.h"

#define currentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIImage(LaunchImage)

+(NSString *)getLaunchImageName{
    NSString *viewOrientation = @"Portrait";
    if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        viewOrientation = @"Landscape";
    }
    NSString *launchImageName = nil;
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = currentWindow.bounds.size;
    for (NSDictionary *dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if(CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

+(UIImage*)getLaunchImage{
    return [UIImage imageNamed:[self getLaunchImageName]];
}

@end
