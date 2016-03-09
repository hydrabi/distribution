//
//  PersonalLocationUITableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalLocationUITableViewCell.h"
#import "UIColor+Addition.h"
@implementation PersonalLocationUITableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.text = @"位置";
    
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
        self.detailLabel.text = user.location;
    }
    else{
        self.detailLabel.text = @"";
    }
}

-(void)fillDetailWithLocation:(NSString*)location{
    self.detailLabel.text = location;
}

@end
