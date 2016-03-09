//
//  CDImageTableViewCellDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/4.
//  Copyright © 2016年 distribution. All rights reserved.
//
#import <Foundation/Foundation.h>
@class CDImageTableViewCell;
@protocol CDImageTableViewCellDelegate <NSObject>

@optional

-(void)imageCell:(CDImageTableViewCell*)imageCell imageClickWithIndex:(NSInteger)index;

@end
