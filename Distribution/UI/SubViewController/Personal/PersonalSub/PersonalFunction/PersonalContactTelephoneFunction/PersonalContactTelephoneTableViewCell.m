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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithType:(PersonalViewTextFieldInputType)type{
    AVUser *user = [AVUser currentUser];
    
    switch (type) {
        case PersonalViewTextFieldInputType_telephone:
        {
            if(user.contactTelephone.length>0){
                self.textField.text = user.contactTelephone;
            }
            else{
                self.textField.text = @"";
                self.textField.placeholder = @"请输入联系电话";
            }
        }
            break;
        case PersonalViewTextFieldInputType_weixin:
        {
            if(user.weixin.length>0){
                self.textField.text = user.weixin;
            }
            else{
                self.textField.text = @"";
                self.textField.placeholder = @"请输入微信账号";
            }
            
        }
            break;
        case PersonalViewTextFieldInputType_qq:
        {
            if(user.qq.length>0){
                self.textField.text = user.qq;
            }
            else{
                self.textField.text = @"";
                self.textField.placeholder = @"请输入QQ账号";
            }
            
        }
            break;
            
        default:
            break;
    }
}

@end
