//
//  SharePopSelectViewTableViewCell.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "SharePopSelectViewTableViewCell.h"
#import "UIColor+Addition.h"
@implementation SharePopSelectViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.textColor                  = [UIColor colorWithHexString:@"#555555" alpha:1];
    self.titleLabel.font                       = [UIFont systemFontOfSize:15.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
