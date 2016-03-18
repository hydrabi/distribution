//
//  DiscoverSubViewListTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubViewListTableViewCell.h"

@interface DiscoverSubViewListTableViewCell()
@property (nonatomic,weak)IBOutlet UIImageView *image;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UILabel *timeLabel;
@end

@implementation DiscoverSubViewListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
