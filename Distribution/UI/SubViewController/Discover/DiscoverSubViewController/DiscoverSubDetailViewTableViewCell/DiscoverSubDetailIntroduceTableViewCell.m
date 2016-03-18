//
//  DiscoverSubDetailIntroduceTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubDetailIntroduceTableViewCell.h"
#import "UIColor+Addition.h"
@interface DiscoverSubDetailIntroduceTableViewCell()
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UILabel *contentLabel;
@property (nonatomic,weak)IBOutlet UIView *lineView;
@end

@implementation DiscoverSubDetailIntroduceTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"303030" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.contentLabel.textColor = [UIColor colorWithHexString:@"4a4a4a" alpha:1];
    self.contentLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [self.lineView setBackgroundColor:[UIColor colorWithHexString:@"b0b0b0" alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithObject:(AVObject*)object{
    self.titleLabel.text = @"活动介绍：";
    self.contentLabel.text = @"独特裁剪，完美曲线，独特裁剪，完美曲线，独特裁剪，完美曲线，独特裁剪，完美曲线，独特裁剪，完美曲线，独特裁剪，完美曲线，独特裁剪，完美曲线";
}

@end
