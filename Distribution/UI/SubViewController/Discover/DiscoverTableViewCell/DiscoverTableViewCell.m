//
//  DiscoverTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import "UIColor+Addition.h"

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLable.font = [UIFont systemFontOfSize:16];
    self.titleLable.textColor = [UIColor colorWithHexString:@"#686868" alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataType:(DiscoverTableDataType)dataType{
    _dataType = dataType;
    self.titleLable.text = [self titleWithDiscoverTableDataType:dataType];
    [self.headImage setImage:[UIImage imageNamed:[self imageNameWithDiscoverTableDataType:dataType]]];
}

#pragma mark - 获取响应的title，图片
-(NSString *)titleWithDiscoverTableDataType:(DiscoverTableDataType)type{
    NSString *title = @"";
    switch (type) {
        case DiscoverTableDataType_service:
            title = @"客服";
            break;
        case DiscoverTableDataType_notification:
            title = @"通知";
            break;
        case DiscoverTableDataType_newActivity:
            title = @"最新活动";
            break;
        default:
            break;
    }
    return title;
}

-(NSString *)imageNameWithDiscoverTableDataType:(DiscoverTableDataType)type{
    NSString *imageName = @"";
    switch (type) {
        case DiscoverTableDataType_service:
            imageName = @"discoverCell_service";
            break;
        case DiscoverTableDataType_notification:
            imageName = @"discoverCell_notification";
            break;
        case DiscoverTableDataType_newActivity:
            imageName = @"discoverCell_newActivity";
            break;
        default:
            break;
    }
    return imageName;
}

@end
