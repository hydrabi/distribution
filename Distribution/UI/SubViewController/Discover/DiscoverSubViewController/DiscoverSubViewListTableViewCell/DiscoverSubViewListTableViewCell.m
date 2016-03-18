//
//  DiscoverSubViewListTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubViewListTableViewCell.h"
#import "UIColor+Addition.h"
@interface DiscoverSubViewListTableViewCell()
@property (nonatomic,weak)IBOutlet UIImageView *image;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UILabel *timeLabel;
@end

@implementation DiscoverSubViewListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3c3c3c" alpha:1];
    
    self.timeLabel.font = [UIFont systemFontOfSize:12.0f];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"afafaf" alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithObject:(AVObject*)object{
    [self.image setImage:[UIImage imageNamed:@"discover_test1"]];
    self.titleLabel.text = @"依云时尚显示大促销";
    self.timeLabel.text = @"2015-11-14";
}

@end
