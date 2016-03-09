//
//  CustomControllerTitleView.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomControllerTitleView.h"

@implementation CustomControllerTitleView

+(instancetype)instanceCustomControllerTitleView{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomControllerTitleView class]) owner:nil options:nil];
    return arr[0];
}

-(void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
    self.mainTitleLabel.font = [UIFont systemFontOfSize:20];
    self.mainTitleLabel.textColor = [UIColor whiteColor];
    
    self.subTitleLabel.font = [UIFont systemFontOfSize:11];
    self.subTitleLabel.textColor = [UIColor whiteColor];
}

@end
