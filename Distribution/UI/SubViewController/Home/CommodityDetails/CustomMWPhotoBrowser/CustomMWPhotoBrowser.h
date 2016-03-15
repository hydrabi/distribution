//
//  CustomMWPhotoBrowser.h
//  Distribution
//
//  Created by Hydra on 16/1/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
@interface CustomMWPhotoBrowser : MWPhotoBrowser
-(instancetype)initWithPhotos:(NSArray *)photosArray delegate:(id <MWPhotoBrowserDelegate>)delegate;
@end
