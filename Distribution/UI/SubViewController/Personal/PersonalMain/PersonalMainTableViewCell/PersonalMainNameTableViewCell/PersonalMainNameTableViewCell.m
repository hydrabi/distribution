//
//  PersonalMainNameTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainNameTableViewCell.h"
#import "UIColor+Addition.h"
#import "ImageManager.h"
#import "PersonalMainMacro.h"
@implementation PersonalMainNameTableViewCell

- (void)awakeFromNib {
    self.nickNameLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.nickNameLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.signatureLabel.textColor = [UIColor colorWithHexString:@"9f9f9f" alpha:1];
    self.signatureLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.headImage.layer.cornerRadius = PersonalMainNameTableViewCell_HeadImageWidthAndHeight/2;
    self.headImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)reloadUserData{
    AVUser *user = [AVUser currentUser];
    if(user){
        [self userHadLogin];
    }
    else{
        [self userAnonymous];
    }
}

//用户已经登录
-(void)userHadLogin{
    AVUser *user = [AVUser currentUser];
    [self.headImage setImage:[ImageManager userHeadImageWithImageName:user]];
    if(user.nickname.length>0){
        self.nickNameLabel.text = user.nickname;
    }
    else{
        self.nickNameLabel.text = @"未设置";
    }
    
    if(user.signature.length>0){
        self.signatureLabel.text = user.signature;
    }
    else{
        self.signatureLabel.text = @"未设置";
    }
}

//用户未登录
-(void)userAnonymous{
    self.nickNameLabel.text = @"未登录";
    self.signatureLabel.text = @"点击登录";
    [self.headImage setImage:[ImageManager userHeadDefaultImage]];
}

@end
