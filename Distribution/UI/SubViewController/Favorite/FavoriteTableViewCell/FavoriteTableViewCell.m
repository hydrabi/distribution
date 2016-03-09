//
//  FavoriteTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "FavoriteTableViewCell.h"
#import "UIColor+Addition.h"
#import "UIImageView+Addition.h"
@implementation FavoriteTableViewCell

- (void)awakeFromNib {
    self.favoriteImage.contentMode    = UIViewContentModeScaleAspectFill;
    self.favoriteImage.clipsToBounds  = YES;
    self.describeLabel.textColor      = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.describeLabel.font           = [UIFont systemFontOfSize:16.0f];
    self.describeLabel.text           = @"";


    self.supplyPriceLabel.textColor   = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.supplyPriceLabel.font        = [UIFont systemFontOfSize:14.0f];
    self.supplyPriceLabel.text        = @"";
    self.suggestPriceLabel.textColor  = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.suggestPriceLabel.font       = [UIFont systemFontOfSize:14.0f];
    self.suggestPriceLabel.text       = @"";
    self.productNumberLabel.textColor = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.productNumberLabel.font      = [UIFont systemFontOfSize:14.0f];
    self.productNumberLabel.text      = @"";
    self.collectNumberLabel.textColor = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.collectNumberLabel.font      = [UIFont systemFontOfSize:14.0f];
    self.collectNumberLabel.text      = @"";

    self.productLabel.textColor       = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.productLabel.font            = [UIFont systemFontOfSize:14.0f];
    self.productLabel.text            = @"货号:";
    self.supplyLabel.textColor        = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.supplyLabel.font             = [UIFont systemFontOfSize:14.0f];
    self.supplyLabel.text             = @"分销价格:";
    self.suggestLabel.textColor       = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.suggestLabel.font            = [UIFont systemFontOfSize:14.0f];
    self.suggestLabel.text            = @"建议价格:";
    self.collectLabel.textColor       = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.collectLabel.font            = [UIFont systemFontOfSize:14.0f];
    self.collectLabel.text            = @"收藏人数:";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWithObject:(AVObject*)object{
    NSDictionary *localData      = [object objectForKey:@"localData"];
    [_favoriteImage downloadImageWithUrl:[localData objectForKey:@"productimg"]];
    self.describeLabel.text      = [localData objectForKey:@"productname"];
    self.supplyPriceLabel.text   = [[localData objectForKey:@"price"] stringValue];
    self.suggestPriceLabel.text  = [[localData objectForKey:@"suggestprice"] stringValue];
    self.productNumberLabel.text = [localData objectForKey:@"productnumber"];

    NSInteger collectNumber      = [[localData objectForKey:Global_ProductCollectNumber] integerValue];
    collectNumber                = collectNumber<0?0:collectNumber;
    self.collectNumberLabel.text = [NSString stringWithFormat:@"%d",collectNumber];
    
}

@end
