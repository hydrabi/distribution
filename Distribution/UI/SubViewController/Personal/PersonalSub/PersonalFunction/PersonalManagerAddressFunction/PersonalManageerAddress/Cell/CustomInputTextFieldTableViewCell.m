//
//  CustomInputTextFieldTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomInputTextFieldTableViewCell.h"
#import "UIColor+Addition.h"

@interface CustomInputTextFieldTableViewCell()

@end

@implementation CustomInputTextFieldTableViewCell

- (void)awakeFromNib {
    self.textField.textColor = [UIColor colorWithHexString:@"747474" alpha:1];
    self.textField.font = [UIFont systemFontOfSize:16.0f];
    self.textField.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setType:(CustomInputTextFieldCellType)type{
    _type = type;
    if(type == CustomInputTextFieldCell_consignee){
        
        self.textField.placeholder = [NSString stringWithFormat:@"请输入收货人名称，不超过%d个字",PersonalManagerAddrestConsigneeMaxLength];
        self.textField.keyboardType = UIKeyboardTypeDefault;
        
    }
    else if (type == CustomInputTextFieldCell_telephone){
        self.textField.placeholder = [NSString stringWithFormat:@"请输入收货人手机号码"];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

@end
