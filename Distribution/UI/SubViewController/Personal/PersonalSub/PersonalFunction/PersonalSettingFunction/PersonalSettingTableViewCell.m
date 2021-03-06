//
//  PersonalSettingTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalSettingTableViewCell.h"
#import "UIColor+Addition.h"
@implementation PersonalSettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cacheLabel.textColor = [UIColor colorWithHexString:@"9f9f9f" alpha:1];
    self.cacheLabel.font      = [UIFont systemFontOfSize:16.0f];
    self.cacheLabel.text      = @"";

    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font      = [UIFont systemFontOfSize:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithType:(PersonalSettingType)type{
    switch (type) {
        case PersonalSettingTypeClearCache:
        {
            self.titleLabel.text = @"缓存清理";
            
            [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize){
                self.cacheLabel.text = [NSString stringWithFormat:@"%.1fM",totalSize/(1024.0*1024)];
            }];
        }
            break;
        case PersonalSettingTypeEvaluate:
        {
            self.titleLabel.text = @"意见反馈";
            self.cacheLabel.text = @"";
        }
            break;
        case PersonalSettingTypeAboutUs:
        {
            self.titleLabel.text = @"关于我们";
            self.cacheLabel.text = @"";
        }
            break;
        default:
            break;
    }
}

@end
