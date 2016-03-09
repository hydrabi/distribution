//
//  FavoriteTableViewHeader.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "FavoriteTableViewHeader.h"
#import "UIColor+Addition.h"
@implementation FavoriteTableViewHeader

-(void)awakeFromNib{
    self.titleLabel.text = @"我的收藏";
    self.titleLabel.textColor = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
}

+(instancetype)instanceFavoriteTableViewHeader{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FavoriteTableViewHeader class]) owner:nil options:nil];
    return arr[0];
}

@end
