//
//  ShoppingCarTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/22.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "UIColor+Addition.h"
@implementation ShoppingCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)UIConfig{
    self.productNameLabel.textColor = [UIColor colorWithHexString:@"4a4a4a" alpha:1];
    self.productNameLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.brandTitleLabel.textColor = [UIColor colorWithHexString:@"7b7b7b" alpha:1];
    self.brandTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.brandTitleLabel.text = @"品牌:";
    
    self.brandLabel.textColor = [UIColor colorWithHexString:@"7b7b7b" alpha:1];
    self.brandLabel.font = [UIFont systemFontOfSize:14.0f];

    self.sizeTitleLabel.textColor = [UIColor colorWithHexString:@"7b7b7b" alpha:1];
    self.sizeTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.sizeTitleLabel.text = @"尺码:";
    
    self.sizeLabel.textColor = [UIColor colorWithHexString:@"7b7b7b" alpha:1];
    self.sizeLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.priceTitleLabel.textColor = [UIColor colorWithHexString:@"7b7b7b" alpha:1];
    self.priceTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.priceTitleLabel.text = @"价格:";
    
    self.priceLabel.textColor = [UIColor colorWithHexString:@"ff6f3b" alpha:1];
    self.priceLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.totalTitleLabel.textColor = [UIColor colorWithHexString:@"7b7b7b" alpha:1];
    self.totalTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.totalTitleLabel.text = @"共计:";
    
    self.totalTitleLabel.textColor = [UIColor colorWithHexString:@"ff6f3b" alpha:1];
    self.totalTitleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    self.minusButton.layer.borderColor = [UIColor colorWithHexString:@"c2c2c2" alpha:1].CGColor;
    self.minusButton.layer.borderWidth = 1.0f;
    [self.minusButton addTarget:self action:@selector(minusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.plusButton.layer.borderColor = [UIColor colorWithHexString:@"c2c2c2" alpha:1].CGColor;
    self.plusButton.layer.borderWidth = 1.0f;
    [self.plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.settleAccoutnButton.layer.cornerRadius = 3.0f;
    self.settleAccoutnButton.clipsToBounds = YES;
    [self.settleAccoutnButton setBackgroundColor:[UIColor colorWithHexString:@"ff6f3b" alpha:1]];
    [self.settleAccoutnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.settleAccoutnButton setTitle:@"前去结算" forState:UIControlStateNormal];
    [self.settleAccoutnButton addTarget:self action:@selector(settleAccoutnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.textField.textColor               = [UIColor colorWithHexString:@"4a4a4a" alpha:1];
    self.textField.font                    = [UIFont systemFontOfSize:14.0f];
    self.textField.keyboardType            = UIKeyboardTypeNumberPad;
    self.textField.layer.borderColor = [UIColor colorWithHexString:@"c2c2c2" alpha:1].CGColor;
    self.textField.layer.borderWidth = 1.0f;
    
    [self.seaprateView setBackgroundColor:[UIColor colorWithHexString:@"c2c2c2" alpha:1]];
    
    [self.image setImage:[UIImage imageNamed:@"shoppingCar_test"]];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 点击事件
/**数量减*/
-(void)minusButtonClick{
    
}

/**数量加*/
-(void)plusButtonClick{
    
}

/**结算点击*/
-(void)settleAccoutnButtonClick{
    
}

@end
