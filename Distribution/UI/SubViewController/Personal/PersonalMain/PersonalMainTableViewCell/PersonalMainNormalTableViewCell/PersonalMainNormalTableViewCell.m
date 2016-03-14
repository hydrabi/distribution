//
//  PersonalMainNormalTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainNormalTableViewCell.h"
#import "UIColor+Addition.h"
@implementation PersonalMainNormalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.detailLabel.textColor = [UIColor colorWithHexString:@"9f9f9f" alpha:1];
    self.detailLabel.font = [UIFont systemFontOfSize:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataType:(PersonalMainTableDataType)dataType{
    _dataType = dataType;
    self.titleLabel.text = [self titleWithPersonalMainTableDataType:dataType];
    [self.headImage setImage:[UIImage imageNamed:[self imageNameWithPersonalMainTableDataType:dataType]]];
    [self detailConfig];
}

-(void)detailConfig{
    AVUser *user = [AVUser currentUser];
    switch (_dataType) {
        case PersonalMainTableDataType_footprint:
        {
            self.arrowImage.hidden = NO;
            self.detailLabel.text = @"";
        }
            break;
        case PersonalMainTableDataType_location:
        {
            self.arrowImage.hidden = YES;
            self.detailLabel.text = user.location;
        }
            break;
        case PersonalMainTableDataType_telephone:
        {
            self.arrowImage.hidden = YES;
            self.detailLabel.text = user.contactTelephone;
        }
            break;
        case PersonalMainTableDataType_recommend:
        {
            self.arrowImage.hidden = NO;
            self.detailLabel.text = @"";
        }
            break;
        case PersonalMainTableDataType_setting:
        {
            self.arrowImage.hidden = NO;
            self.detailLabel.text = @"";
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 获取响应的title，图片
-(NSString *)titleWithPersonalMainTableDataType:(PersonalMainTableDataType)type{
    NSString *title = @"";
    switch (type) {
        case PersonalMainTableDataType_footprint:
            title = @"我的足迹";
            break;
        case PersonalMainTableDataType_location:
            title = @"位置";
            break;
        case PersonalMainTableDataType_telephone:
            title = @"联系电话";
            break;
        case PersonalMainTableDataType_recommend:
            title = @"推荐给好友";
            break;
        case PersonalMainTableDataType_setting:
            title = @"设置";
            break;
        default:
            break;
    }
    return title;
}

-(NSString *)imageNameWithPersonalMainTableDataType:(PersonalMainTableDataType)type{
    NSString *imageName = @"";
    switch (type) {
        case PersonalMainTableDataType_footprint:
            imageName = @"personalCell_footprint";
            break;
        case PersonalMainTableDataType_location:
            imageName = @"personalCell_location";
            break;
        case PersonalMainTableDataType_telephone:
            imageName = @"personalCell_telephone";
            break;
        case PersonalMainTableDataType_recommend:
            imageName = @"personalCell_recommend";
            break;
        case PersonalMainTableDataType_setting:
            imageName = @"personalCell_setting";
            break;
        default:
            break;
    }
    return imageName;
}

@end
