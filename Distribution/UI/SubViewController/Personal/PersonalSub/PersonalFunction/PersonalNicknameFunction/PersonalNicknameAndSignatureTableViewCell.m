//
//  PersonalNicknameAndSignatureTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/29.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalNicknameAndSignatureTableViewCell.h"
#import "UIColor+Addition.h"

@implementation PersonalNicknameAndSignatureTableViewCell

- (void)awakeFromNib {
    self.textFileld.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.textFileld.font = [UIFont systemFontOfSize:16.0f];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setType:(PersonalInputAttributeType)type{
    _type = type;
    AVUser *user = [AVUser currentUser];
    if(type == PersonalInputAttributeType_nickname){
        if(user.nickname.length>0){
            self.textFileld.text = user.nickname;
        }
        else{
            self.textFileld.text = @"";
            self.textFileld.placeholder = [NSString stringWithFormat:@"请输入昵称，不超过%d字",maxNicknameLength];
        }
    }
    else if (type == PersonalInputAttributeType_signature){
        if(user.signature.length>0){
            self.textFileld.text = user.signature;
        }
        else{
            self.textFileld.text = @"";
            self.textFileld.placeholder = [NSString stringWithFormat:@"请输入昵称，不超过%d字",maxSignatureLength];
        }
    }
}

@end
