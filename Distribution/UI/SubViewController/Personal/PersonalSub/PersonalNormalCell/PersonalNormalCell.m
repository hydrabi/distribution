//
//  PersonalNormalCell.m
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PersonalNormalCell.h"
#import "UIColor+Addition.h"
@implementation PersonalNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLable.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLable.font = [UIFont systemFontOfSize:16.0f];
    
    self.detailLabel.textColor = [UIColor colorWithHexString:@"9f9f9f" alpha:1];
    self.detailLabel.font = [UIFont systemFontOfSize:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)detailConfigWithType:(PersonalTableDataType)type{
    PersonlInfoManager *manager = [PersonlInfoManager shareManager];
    if([manager hadLogin]){
        AVUser *user = [AVUser currentUser];
        [self fillDetailWithType:type user:user];
    }
    else{
        self.detailLabel.text = @"未设置";
    }
}

-(void)fillDetailWithType:(PersonalTableDataType)type user:(AVUser*)user{
    switch (type) {
        case PersonalTableDataType_age:
        {
            [self fillDetailLabelText:user.age];
        }
            break;
        case PersonalTableDataType_gender:
        {
            [self fillDetailLabelText:user.gender];
        }
            break;
        case PersonalTableDataType_location:
        {
            [self fillDetailLabelText:user.location];
        }
            break;
        case PersonalTableDataType_telephone:
        {
            [self fillDetailLabelText:user.contactTelephone];
        }
            break;
        case PersonalTableDataType_nickname:
        {
            [self fillDetailLabelText:user.nickname];
        }
            break;
        case PersonalTableDataType_signature:
        {
            [self fillDetailLabelText:user.signature];
        }
            break;
        default:
            break;
    }
}

-(void)fillDetailLabelText:(NSString*)text{
    if(text.length==0){
        self.detailLabel.text = @"未设置";
    }
    else{
        self.detailLabel.text = text;
    }
}

@end
