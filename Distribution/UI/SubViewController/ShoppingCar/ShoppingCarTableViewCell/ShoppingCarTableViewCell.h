//
//  ShoppingCarTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/22.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *productNameLabel;
/**
 *  品牌标题
 */
@property (nonatomic,weak)IBOutlet UILabel *brandTitleLabel;
/**
 *  品牌
 */
@property (nonatomic,weak)IBOutlet UILabel *brandLabel;
/**
 *  尺码标题
 */
@property (nonatomic,weak)IBOutlet UILabel *sizeTitleLabel;
/**
 *  尺码
 */
@property (nonatomic,weak)IBOutlet UILabel *sizeLabel;
/**
 *  价格标题
 */
@property (nonatomic,weak)IBOutlet UILabel *priceTitleLabel;
/**
 *  价格
 */
@property (nonatomic,weak)IBOutlet UILabel *priceLabel;
/**
 *  总计标题
 */
@property (nonatomic,weak)IBOutlet UILabel *totalTitleLabel;
/**
 *  总计
 */
@property (nonatomic,weak)IBOutlet UILabel *totalLabel;
/**
 *  减按钮
 */
@property (nonatomic,weak)IBOutlet UIButton *minusButton;
/**
 *  加按钮
 */
@property (nonatomic,weak)IBOutlet UIButton *plusButton;
/**
 *  删除按钮
 */
@property (nonatomic,weak)IBOutlet UIButton *deleteButton;
/**
 *  结算按钮
 */
@property (nonatomic,weak)IBOutlet UIButton *settleAccoutnButton;
/**
 *  数目textField
 */
@property (nonatomic,weak)IBOutlet UITextField *textField;
/**
 *  分隔线
 */
@property (nonatomic,weak)IBOutlet UIView *seaprateView;

@property (nonatomic,weak)IBOutlet UIImageView *image;
@end
