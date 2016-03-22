//
//  ClassifyViewCollectViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ClassifyViewCollectViewCell.h"
#import "UIColor+Addition.h"
@interface ClassifyViewCollectViewCell()
@property (nonatomic,weak)IBOutlet UIImageView *imageView;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@end

@implementation ClassifyViewCollectViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    self.titleLabel.font      = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
}

-(void)resetValueWithType:(productType)type{
    switch (type) {
        case productType_women:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_women"]];
            self.titleLabel.text = @"全部女装";
        }
            break;
        case productType_sweater:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_sweater"]];
            self.titleLabel.text = @"针织衫/毛衣";
        }
            break;
        case productType_summer:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_summer"]];
            self.titleLabel.text = @"夏装";
        }
            break;
        case productType_autumn:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_autumn"]];
            self.titleLabel.text = @"秋装";
        }
            break;
        case productType_pantyHose:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_pantyHose"]];
            self.titleLabel.text = @"裤袜";
        }
            break;
        case productType_overcoat:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_overcoat"]];
            self.titleLabel.text = @"风衣/大衣";
        }
            break;
        case productType_minkCoat:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_minkCoat"]];
            self.titleLabel.text = @"貂皮大衣";
        }
            break;
        case productType_jacket:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_jacket"]];
            self.titleLabel.text = @"外套";
        }
            break;
        case productType_fachion:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_fachion"]];
            self.titleLabel.text = @"时尚装";
        }
            break;
        case productType_dress:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_dress"]];
            self.titleLabel.text = @"连衣裙";
        }
            break;
        case productType_downJacket:
        {
            [self.imageView setImage:[UIImage imageNamed:@"classify_downJacket"]];
            self.titleLabel.text = @"羽绒服";
        }
            break;
            
        default:
            break;
    }
}

@end
