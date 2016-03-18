//
//  DiscoverSubDetailImageTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubDetailImageTableViewCell.h"
#import "UIColor+Addition.h"
@interface DiscoverSubDetailImageTableViewCell()
@property (nonatomic,weak)IBOutlet UIImageView *image;
@property (nonatomic,weak)IBOutlet UIView *lineView;
@end

@implementation DiscoverSubDetailImageTableViewCell

- (void)awakeFromNib {
    [self.lineView setBackgroundColor:[UIColor colorWithHexString:@"b0b0b0" alpha:1]];
    [self.image setImage:[UIImage imageNamed:@"discover_test2"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
