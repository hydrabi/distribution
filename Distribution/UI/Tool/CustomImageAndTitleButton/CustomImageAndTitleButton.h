//
//  CustomImageAndTitleButton.h
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageAndTitleButton : UIButton

-(void)configButtonImageName:(NSString*)imageName title:(NSString*)title middleOffset:(CGFloat)middleOffset buttonHeight:(CGFloat)buttonHeight titleFont:(UIFont*)font;

@end
