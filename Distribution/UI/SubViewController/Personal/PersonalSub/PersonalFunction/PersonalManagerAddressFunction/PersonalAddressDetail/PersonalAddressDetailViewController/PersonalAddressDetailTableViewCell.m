//
//  PersonalAddressDetailTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAddressDetailTableViewCell.h"
#import "UIColor+Addition.h"

@implementation PersonalAddressDetailTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = PersonalAddrestDetailCellTitleColor;
    self.titleLabel.font = PersonalAddrestDetailTitleFont;
    
    self.valueLabel.textColor = PersonalAddrestDetailCellValueColor;
    self.valueLabel.font = PersonalAddrestDetailTitleFont;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithType:(PersonalAddressDetailCellType)type addressDic:(NSDictionary*)dic{
    switch (type) {
        case PersonalAddressDetailCellType_consignee:
        {
            self.titleLabel.text = @"收货人：";
            self.titleLabel.textColor = PersonalAddrestDetailCellTitleColor;
            self.valueLabel.text = dic[AVUserKey_addressConsignee];
        }
            break;
        case PersonalAddressDetailCellType_telephone:
        {
            self.titleLabel.text = @"手机号码：";
            self.titleLabel.textColor = PersonalAddrestDetailCellTitleColor;
            self.valueLabel.text = dic[AVUserKey_addressTelephone];
        }
            break;
        case PersonalAddressDetailCellType_area:
        {
            self.titleLabel.text = @"所在地区：";
            self.titleLabel.textColor = PersonalAddrestDetailCellTitleColor;
            self.valueLabel.text = dic[AVUserKey_addressLocation];
        }
            break;
        case PersonalAddressDetailCellType_detailAddress:
        {
            self.titleLabel.text = @"详细地址：";
            self.titleLabel.textColor = PersonalAddrestDetailCellTitleColor;
            self.valueLabel.text = dic[AVUserKey_addressDetail];
        }
            break;
        case PersonalAddressDetailCellType_delete:
        {
            self.titleLabel.text = @"删除收货地址";
            self.valueLabel.text = @"";
            self.titleLabel.textColor = [UIColor redColor];
        }
            break;
            
        default:
            break;
    }
}

@end
