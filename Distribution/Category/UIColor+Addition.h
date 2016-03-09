//
//  UIColor+Addition.h
//  FoodDelivered
//
//  Created by Hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor(Addition)

/**根据RGB颜色值获得颜色*/
+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b;

/**根据RGBA颜色值获得颜色*/
+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b A:(int)a;


//FIXME:使用Error方式调用
/**根据16进制颜色值获得颜色*/
+ (UIColor *)colorWithRGB:(NSUInteger )rgbValue;
/**根据16进制文本获得颜色*/
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

- (NSString *)hexString;

@end
