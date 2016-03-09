//
//  PersonalAgeTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAgeTableViewCell.h"
#import "UIColor+Addition.h"
@implementation PersonalAgeTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.text = @"年龄";
    
    self.detailLabel.textColor = [UIColor colorWithHexString:@"9f9f9f" alpha:1];
    self.detailLabel.font = [UIFont systemFontOfSize:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)detailConfig{
    PersonlInfoManager *manager = [PersonlInfoManager shareManager];
    if([manager hadLogin]){
        AVUser *user = [AVUser currentUser];
        self.detailLabel.text = user.age;
    }
    else{
        self.detailLabel.text = @"";
    }
}

-(void)fillDetailWithAge:(NSInteger)age{
    self.detailLabel.text = [NSString stringWithFormat:@"%ld",(long)age];
}

@end
