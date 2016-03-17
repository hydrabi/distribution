//
//  VerifyButtonTextFieldTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "VerifyButtonTextFieldTableViewCell.h"
#import "UIColor+Addition.h"
@implementation VerifyButtonTextFieldTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor   = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font        = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.text        = @"验证码";

    self.textField.textColor    = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.textField.font         = [UIFont systemFontOfSize:16.0f];
    self.textField.placeholder  = @"输入验证码";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    //验证按钮暗淡时颜色为#b7b7b7
    [self.verifyButton setTitleColor:[UIColor colorWithHexString:@"3f3f3f" alpha:1] forState:UIControlStateNormal];
    [self.verifyButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
