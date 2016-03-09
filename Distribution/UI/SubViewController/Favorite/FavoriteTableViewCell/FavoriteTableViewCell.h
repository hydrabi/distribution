//
//  FavoriteTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

/**
 *  供货价(价格)
 */
@property (weak, nonatomic) IBOutlet UILabel *supplyPriceLabel;
/**
 *  建议价（价格）
 */
@property (weak, nonatomic) IBOutlet UILabel *suggestPriceLabel;
/**
 *  供货价
 */
@property (weak, nonatomic) IBOutlet UILabel *supplyLabel;
/**
 *  建议价
 */
@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;
/**
 *  货号
 */
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
/**
 *  货号（数量）
 */
@property (weak, nonatomic) IBOutlet UILabel *productNumberLabel;
/**
 *  收藏人数
 */
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
/**
 *  收藏人数(数量)
 */
@property (weak, nonatomic) IBOutlet UILabel *collectNumberLabel;

-(void)resetValueWithObject:(AVObject*)object;

@end
