//
//  PersonalHeaderCell.m
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PersonalHeaderCell.h"
#import "UIColor+Addition.h"
#import "ImageManager.h"
#import "AVUser+Attibute.h"
#import "PersonalMacro.h"
@implementation PersonalHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.headLabel.font = [UIFont systemFontOfSize:16.0f];
    self.headImage.layer.cornerRadius = PersonalHeadCellImageHeight/2;
    self.headImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)detailConfig{
    AVUser *user = [AVUser currentUser];
    [self.headImage setImage:[ImageManager userHeadImageWithImageName:user]];
}

@end
