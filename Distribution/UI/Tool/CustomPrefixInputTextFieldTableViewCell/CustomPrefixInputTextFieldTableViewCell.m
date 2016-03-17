//
//  CustomPrefixInputTextFieldTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "UIColor+Addition.h"
@interface CustomPrefixInputTextFieldTableViewCell()
@property (nonatomic,strong)UIButton *rightViewButton;
@end

@implementation CustomPrefixInputTextFieldTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.textField.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.textField.font = [UIFont systemFontOfSize:16.0f];
    
    UIImage *image = [UIImage imageNamed:@"personalCell_passwordVisable"];
    self.rightViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [self.rightViewButton setImage:image forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setType:(AccountReleateCellType)type{
    switch (type) {
        case AccountReleateCellType_loginAccount:
        {
            self.titleLabel.text = @"账号";
            self.textField.placeholder = @"手机号码";
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case AccountReleateCellType_loginPassword:
        {
            self.titleLabel.text = @"密码";
            self.textField.placeholder = @"登录密码";
            self.textField.rightView = self.rightViewButton;
            self.textField.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case AccountReleateCellType_registerTelephone:
        {
            self.titleLabel.text = @"手机号码";
            self.textField.placeholder = @"请填写手机号码";
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case AccountReleateCellType_registerSettingPassword:
        {
            self.titleLabel.text = @"新密码";
            self.textField.placeholder = @"账号密码(6-12)";
        }
            break;
        case AccountReleateCellType_forgetPasswordTelephone:
        {
            self.titleLabel.text = @"手机号码";
            self.textField.placeholder = @"请填写手机号码";
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case AccountReleateCellType_forgetPasswordNewPassword:
        {
            self.titleLabel.text = @"新密码";
            self.textField.placeholder = @"账号密码(6-12)";
        }
            break;
            
        default:
            break;
    }
}

@end
