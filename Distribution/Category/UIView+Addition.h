//
//  UIView+Addition.h
//  Distribution
//
//  Created by Hydra on 15/12/29.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIView(Addition)

+(CGFloat)loginViewHeight;

-(void)makeSpecificConstraintsWithTop:(CGFloat)top;

-(void)makeNormalConstraints;

@end
