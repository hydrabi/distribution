//
//  SearchProductDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/3/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchProductDataSourceDelegate <NSObject>

@optional

/**
 *  通知委托点击了某个cell
 *
 *  @param object cell所对应的AVobject
 */
-(void)didSelectRowWithObject:(AVObject*)object;

@end
