//
//  CustomPrefixInputTextFieldTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "UIColor+Addition.h"
@implementation CustomPrefixInputTextFieldTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.textField.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.textField.font = [UIFont systemFontOfSize:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
