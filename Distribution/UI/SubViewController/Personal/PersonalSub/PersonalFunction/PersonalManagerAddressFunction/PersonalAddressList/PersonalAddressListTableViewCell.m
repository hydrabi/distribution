//
//  PersonalAddressListTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAddressListTableViewCell.h"
#import "UIColor+Addition.h"
#import "PersonalManagerAddressMacro.h"
@implementation PersonalAddressListTableViewCell

- (void)awakeFromNib {
    self.nameLabel.textColor = PersonalAddrestListCellTitleColor;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    
    self.telephoneLabel.textColor = PersonalAddrestListCellTitleColor;
    self.telephoneLabel.font = [UIFont systemFontOfSize:15];
    
    self.adressLabel.textColor = PersonalAddrestListCellTitleColor;
    self.adressLabel.font = [UIFont systemFontOfSize:15];
    
    self.nameLabel.text = @"毕先生";
    self.telephoneLabel.text = @"13410424125";
    self.adressLabel.text = @"冻死了客服及阿里的咖啡机拉到就发啦几点睡了房间啊看来对方";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWith{
    self.nameLabel.text = @"毕先生";
    self.telephoneLabel.text = @"13410424125";
    self.adressLabel.text = @"冻死了客服及阿里的咖啡机拉到就发啦几点睡了房间啊看来对方";
}

@end
