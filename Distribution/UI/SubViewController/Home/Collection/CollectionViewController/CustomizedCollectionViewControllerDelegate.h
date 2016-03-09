//
//  CustomizedCollectionViewControllerDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol CustomizedCollectionViewControllerDelegate <NSObject>

@optional

-(void)pushIntoCommodityDitailsControllerWithIndexPath:(NSIndexPath *)indexPath object:(AVObject*)object;

@end
