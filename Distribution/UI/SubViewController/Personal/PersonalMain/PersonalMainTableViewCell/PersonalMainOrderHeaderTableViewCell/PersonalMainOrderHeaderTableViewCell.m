//
//  PersonalMainOrderHeaderTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/29.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainOrderHeaderTableViewCell.h"
#import "UIColor+Addition.h"
@implementation PersonalMainOrderHeaderTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.text = @"我的订单";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
