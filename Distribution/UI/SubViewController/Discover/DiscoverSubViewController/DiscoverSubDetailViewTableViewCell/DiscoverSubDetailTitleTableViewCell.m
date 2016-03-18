//
//  DiscoverSubDetailTitleTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubDetailTitleTableViewCell.h"
#import "UIColor+Addition.h"
@interface DiscoverSubDetailTitleTableViewCell()
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UILabel *writerLabel;
@property (nonatomic,weak)IBOutlet UILabel *timeLabel;
@property (nonatomic,weak)IBOutlet UIView *lineView;
@end
@implementation DiscoverSubDetailTitleTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0f0f0f" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    
    self.writerLabel.textColor = [UIColor colorWithHexString:@"a0a0a0" alpha:1];
    self.writerLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.timeLabel.textColor = [UIColor colorWithHexString:@"a0a0a0" alpha:1];
    self.timeLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [self.lineView setBackgroundColor:[UIColor colorWithHexString:@"b0b0b0" alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
