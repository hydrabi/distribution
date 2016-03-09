//
//  ClassifyViewTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ClassifyViewTableViewCell.h"
#import "UIColor+Addition.h"
@interface ClassifyViewTableViewCell()

@property (nonatomic,assign)productType type;

@end

@implementation ClassifyViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"858585" alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithType:(productType)type{
    self.type = type;
    switch (type) {
        case productType_overcoat:
        {
            [self.headImage setImage:[UIImage imageNamed:@"classify_overcoat"]];
            self.titleLabel.text = @"大衣";
        }
            break;
        case productType_trousers:
        {
            [self.headImage setImage:[UIImage imageNamed:@"classify_trousers"]];
            self.titleLabel.text = @"裤类";
        }
            break;
        case productType_dress:
        {
            [self.headImage setImage:[UIImage imageNamed:@"classify_dress"]];
            self.titleLabel.text = @"裙子";
        }
            break;
        case productType_sweater:
        {
            [self.headImage setImage:[UIImage imageNamed:@"classify_swieater"]];
            self.titleLabel.text = @"毛衣";
        }
            break;
        default:
            break;
    }
}

@end
