//
//  CDMainTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageAndTitleButton.h"
#import "CDMainTableViewCellDelegate.h"
@interface CDMainTableViewCell : UITableViewCell

/**选择的size*/
typedef NS_ENUM(NSInteger,CDMainCellSizeType){
    CDMainCellSizeType_MSize,
    CDMainCellSizeType_LSize,
    CDMainCellSizeType_XLSize,
    CDMainCellSizeType_XXLSize,
};

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
/**
 *  分销价(价格)
 */
@property (weak, nonatomic) IBOutlet UILabel *distributePriceLabel;
/**
 *  建议价（价格）
 */
@property (weak, nonatomic) IBOutlet UILabel *suggestPriceLabel;
/**
 *  分销价
 */
@property (weak, nonatomic) IBOutlet UILabel *distributeLabel;
/**
 *  建议价
 */
@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;
/**
 *  收藏按钮
 */
@property (weak, nonatomic) IBOutlet CustomImageAndTitleButton *favoriteButton;
/**
 *  数量（标题）
 */
@property (weak,nonatomic)IBOutlet UILabel *numberTitleLabel;

@property (weak,nonatomic)IBOutlet UIButton *minusButton;
@property (weak,nonatomic)IBOutlet UIButton *plusButton;
@property (weak,nonatomic)IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (weak, nonatomic) IBOutlet UIButton *mSizeButton;
@property (weak, nonatomic) IBOutlet UIButton *lsizeButton;
@property (weak, nonatomic) IBOutlet UIButton *xlSizeButton;
@property (weak, nonatomic) IBOutlet UIButton *xxlSizeButton;

/**
 *  已经选中的size类型
 */
@property (assign,nonatomic)CDMainCellSizeType selectedSizeType;

@property (weak,nonatomic)id<CDMainTableViewCellDelegate> delegate;

-(void)resetValueWithObject:(AVObject*)object;

@end
