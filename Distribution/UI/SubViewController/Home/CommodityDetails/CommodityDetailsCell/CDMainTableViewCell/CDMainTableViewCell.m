//
//  CDMainTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CDMainTableViewCell.h"
#import "UIColor+Addition.h"
#import "CommodityDetailsMacro.h"
#import "AppDelegate.h"
#import "UIImageView+Addition.h"

@interface CustomTextfield : UITextField

@end

@implementation CustomTextfield

-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectInset(bounds, -2, 0);
    return inset;
}

@end

@interface CDMainTableViewCell()

@property (nonatomic,strong)NSArray *sizeButtonArr;
@property (nonatomic,strong)AVObject *object;
@property (nonatomic,strong)UITapGestureRecognizer *mainImageTap;
/**
 *  选择的商品数目
 */
@property (nonatomic,assign)NSUInteger selectProductNumber;
@end

@implementation CDMainTableViewCell

- (void)awakeFromNib {
    self.mainImage.contentMode             = UIViewContentModeScaleAspectFill;
    self.mainImage.clipsToBounds           = YES;

    self.mainImageTap                      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTagAction:)];
    self.mainImage.userInteractionEnabled  = YES;
    [self.mainImage addGestureRecognizer:self.mainImageTap];

    self.productNameLabel.textColor        = [UIColor colorWithHexString:@"282324" alpha:1];
    self.productNameLabel.font             = [UIFont systemFontOfSize:16.0f];
    self.productNameLabel.text             = @"";
    self.distributePriceLabel.textColor    = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.distributePriceLabel.font         = [UIFont systemFontOfSize:15.0f];
    self.distributePriceLabel.text         = @"";
    self.suggestPriceLabel.textColor       = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.suggestPriceLabel.font            = [UIFont systemFontOfSize:15.0f];
    self.suggestPriceLabel.text            = @"";
    self.productNumberLabel.textColor      = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.productNumberLabel.font           = [UIFont systemFontOfSize:15.0f];
    self.productNumberLabel.text           = @"";
    self.brandNameLabel.textColor          = [UIColor colorWithHexString:@"ff633b" alpha:1];
    self.brandNameLabel.font               = [UIFont systemFontOfSize:15.0f];
    self.brandNameLabel.text               = @"";

    self.distributeLabel.textColor         = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.distributeLabel.font              = [UIFont systemFontOfSize:15.0f];
    self.distributeLabel.text              = @"分销价格:";
    self.suggestLabel.textColor            = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.suggestLabel.font                 = [UIFont systemFontOfSize:15.0f];
    self.suggestLabel.text                 = @"建议价格:";
    self.numberTitleLabel.textColor        = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.numberTitleLabel.font             = [UIFont systemFontOfSize:15.0f];
    self.numberTitleLabel.text             = @"数量:";
    self.productNumberTitleLabel.textColor = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.productNumberTitleLabel.font      = [UIFont systemFontOfSize:15.0f];
    self.productNumberTitleLabel.text      = @"货号:";
    self.brandLabel.textColor              = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.brandLabel.font                   = [UIFont systemFontOfSize:15.0f];
    self.brandLabel.text                   = @"品牌:";

    self.selectProductNumber               = 1;
    self.textField.textColor               = [UIColor colorWithHexString:@"3d3d3d" alpha:1];
    self.textField.font                    = [UIFont systemFontOfSize:15.0f];
    self.textField.text                    = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectProductNumber];
    self.textField.keyboardType            = UIKeyboardTypeNumberPad;

    [self.minusButton addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.plusButton addTarget:self action:@selector(plusButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.shareButton addTarget:self action:@selector(weixinShareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.clipsToBounds      = YES;
    self.shareButton.layer.cornerRadius = 2.0f;
    self.shareButton.layer.borderWidth  = 1.0f;
    [self.shareButton configButtonImageName:@"commodityDefault_weixinShare" title:@"分享到微信" middleOffset:5.0f buttonHeight:CommodityDetailsWeiXinButtonHeight titleFont:[UIFont systemFontOfSize:15.0f]];
    [self.shareButton setBackgroundColor:[UIColor colorWithHexString:@"ff4400" alpha:0.2]];
    [self.shareButton setTitleColor:[UIColor colorWithHexString:@"ff4400" alpha:1] forState:UIControlStateNormal];
    self.shareButton.layer.borderColor  = [UIColor colorWithHexString:@"ff4400" alpha:0.3].CGColor;
    

    self.mSizeButton.layer.borderWidth     = 1.0f;
    self.lsizeButton.layer.borderWidth     = 1.0f;
    self.xlSizeButton.layer.borderWidth    = 1.0f;
    self.xxlSizeButton.layer.borderWidth   = 1.0f;
    
    if(!self.sizeButtonArr){
        self.sizeButtonArr = @[self.mSizeButton,
                               self.lsizeButton,
                               self.xlSizeButton,
                               self.xxlSizeButton];
        
        for(UIButton *button in self.sizeButtonArr){
            button.layer.borderWidth = 1.0f;
            [button addTarget:self action:@selector(sizeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.selectedSizeType = CDMainCellSizeType_MSize;
    
    [self.textField addTarget:self action:@selector(textFieldEditChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)resetValueWithObject:(AVObject*)object{
    self.object = object;

    NSDictionary *localData        = [object objectForKey:@"localData"];

    [_mainImage downloadImageWithUrl:[localData objectForKey:@"productimg"]];
    self.productNameLabel.text     = [localData objectForKey:@"productname"];
    self.distributePriceLabel.text = [[localData objectForKey:@"price"] stringValue];
    self.suggestPriceLabel.text    = [[localData objectForKey:@"suggestprice"] stringValue];
    self.productNumberLabel.text   = [localData objectForKey:@"productnumber"];

    self.brandNameLabel.text           = @"耐克";
}

#pragma mark - size大小按钮点击

-(void)sizeButtonClick:(UIButton*)button{
    self.selectedSizeType = button.tag;
}

-(void)setSelectedSizeType:(CDMainCellSizeType)selectedSizeType{
    _selectedSizeType = selectedSizeType;
    for(UIButton *button in self.sizeButtonArr){
        if(button.tag == selectedSizeType){
            [self didSelected:YES sizeButton:button];
        }
        else{
            [self didSelected:NO sizeButton:button];
        }
    }
}

-(void)didSelected:(BOOL)selected sizeButton:(UIButton*)sizeButton{
    UIColor *unSelectedTitleColor = [UIColor colorWithHexString:@"#3d3d3d" alpha:1];
    UIColor *selectedTitleColor = [UIColor colorWithHexString:@"ff4400" alpha:1];
    UIColor *unSelectedBorderColor = [UIColor colorWithHexString:@"#dfdfdf" alpha:1];
    UIColor *selectedBorderColor = [UIColor colorWithHexString:@"ff4400" alpha:1];
    if(selected){
        [sizeButton setTitleColor:selectedTitleColor forState:UIControlStateNormal];
        sizeButton.layer.borderColor = selectedBorderColor.CGColor;
    }
    else{
        [sizeButton setTitleColor:unSelectedTitleColor forState:UIControlStateNormal];
        sizeButton.layer.borderColor = unSelectedBorderColor.CGColor;
    }
}

#pragma mark - 微信分享
-(void)weixinShareButtonClick{
    if(self.delegate && [self.delegate respondsToSelector:@selector(weixinShareButtonClick)]){
        [self.delegate weixinShareButtonClick];
    }
}

#pragma mark - 收藏
/**按钮点击事件*/
//-(void)favoriteButtonClick{
//    AVUser *user = [AVUser currentUser];
//    //已经登录
//    if(user){
//        BOOL favorited = [user containFavoriteObjectId:self.object.objectId];
//        //未加入收藏，商品加入收藏
//        if(!favorited){
//            [user addFavoriteWithObjectId:self.object];
//            [MBProgressHUD showSuccess:@"加入收藏成功！"];
//            [self hadAddFavorite:YES];
//            
//        }
//        else{
//            [user removeFavoriteWithObjectId:self.object];
//            [MBProgressHUD showSuccess:@"取消收藏成功！"];
//            [self hadAddFavorite:NO];
//            
//        }
//    }
//    //未登录，弹出登录框
//    else{
//        [[LoginNavigationControllerViewController shareInstance] showWithRootViewController];
//    }
//}

/**根据是否收藏按钮的显示状态不同*/
//-(void)hadAddFavorite:(BOOL)favorite{
//    UIFont *font                           = [UIFont systemFontOfSize:15.0f];
//    //未加入收藏
//    if(!favorite){
//        [self.favoriteButton configButtonImageName:@"favoriteButtonHeart" title:@"加入收藏" middleOffset:5.0f buttonHeight:CommodityDetailsFavoriteButtonHeight titleFont:font];
//        [self.favoriteButton setBackgroundColor:[UIColor colorWithHexString:@"ff4400" alpha:0.2]];
//        [self.favoriteButton setTitleColor:[UIColor colorWithHexString:@"ff4400" alpha:1] forState:UIControlStateNormal];
//        self.favoriteButton.layer.borderColor  = [UIColor colorWithHexString:@"ff4400" alpha:0.3].CGColor;
//    }
//    //已加入收藏
//    else{
//        [self.favoriteButton configButtonImageName:nil title:@"取消收藏" middleOffset:5.0f buttonHeight:CommodityDetailsFavoriteButtonHeight titleFont:font];
//        [self.favoriteButton setBackgroundColor:[UIColor grayColor]];
//        self.favoriteButton.layer.borderColor  = [UIColor grayColor].CGColor;
//        [self.favoriteButton setTitleColor:[UIColor colorWithHexString:@"ffffff" alpha:1] forState:UIControlStateNormal];
//    }
//}

-(void)imageTagAction:(UITapGestureRecognizer*)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickImageCell:)]){
        [self.delegate clickImageCell:self];
    }
}

-(void)minusButtonAction:(id)sender{
    if(self.selectProductNumber>0){
        self.selectProductNumber -= 1;
        self.textField.text = [NSString stringWithFormat:@"%d",self.selectProductNumber];
    }
}

-(void)plusButtonAction:(id)sender{
    self.selectProductNumber += 1;
    self.textField.text = [NSString stringWithFormat:@"%d",self.selectProductNumber];
}

-(void)textFieldEditChange:(UITextField*)textField{
    NSMutableString *s = [textField.text mutableCopy];
    self.selectProductNumber = [s integerValue];
}

@end
