//
//  PersonalContactTelephoneTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalContactTelephoneTableViewCell.h"
#import "UIColor+Addition.h"
@implementation PersonalContactTelephoneTableViewCell

- (void)awakeFromNib {
    self.textField.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.textField.font = [UIFont systemFontOfSize:16.0f];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    AVUser *user = [AVUser currentUser];
    if(user.contactTelephone.length>0){
        self.textField.text = user.contactTelephone;
    }
    else{
        self.textField.text = @"";
        self.textField.placeholder = @"请输入联系电话";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
