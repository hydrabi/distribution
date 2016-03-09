//
//  PersonalMainTableViewHeader.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainTableViewHeader.h"
#import "UIColor+Addition.h"
@implementation PersonalMainTableViewHeader

+(instancetype)instancePersonalMainTableViewHeader{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PersonalMainTableViewHeader class]) owner:nil options:nil];
    return arr[0];
}

-(void)awakeFromNib{
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
}



@end
