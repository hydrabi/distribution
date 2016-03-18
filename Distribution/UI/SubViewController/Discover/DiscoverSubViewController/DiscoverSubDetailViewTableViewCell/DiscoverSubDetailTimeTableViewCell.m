//
//  DiscoverSubDetailTimeTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubDetailTimeTableViewCell.h"
#import "UIColor+Addition.h"
@interface DiscoverSubDetailTimeTableViewCell()
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@end

@implementation DiscoverSubDetailTimeTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"a0a0a0" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
