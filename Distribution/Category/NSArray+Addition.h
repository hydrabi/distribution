//
//  NSArray+Addition.h
//  Distribution
//
//  Created by Hydra on 16/1/26.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(Addition)

/**
 *  创建带图片的导航栏按钮
 *
 *  @param imageName 图片名称
 *  @param target    按钮目标
 *  @param selecter  按钮事件
 *
 *  @return 带图片的导航栏按钮
 */
+(NSArray*)navigationItemsWithImageName:(NSString *)imageName target:(id)target selecter:(SEL)selecter;

/**
 *  创建表示返回的导航栏按钮
 *
 *  @param target   按钮目标
 *  @param selector 按钮事件
 *
 *  @return 表示返回的导航栏按钮
 */
+(NSArray*)navigationItemsReturnWithTarget:(id)target selecter:(SEL)selector;

@end
