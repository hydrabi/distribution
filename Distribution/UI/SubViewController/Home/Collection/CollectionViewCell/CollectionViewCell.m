//
//  CollectionViewCell.m
//  Distribution
//
//  Created by Hydra on 15/12/17.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CustomizedCollectionMacro.h"
#import "UIColor+Addition.h"
#import "UIImageView+Addition.h"
@interface CollectionViewCell ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *collectImage;
/**
 *  货号标题
 */
@property (weak, nonatomic) IBOutlet UILabel *productNumberTitleLabel;
/**
 *  货号值
 */
@property (weak, nonatomic) IBOutlet UILabel *productNumberValueLabel;

/**
 *  分销价值
 */
@property (weak, nonatomic) IBOutlet UILabel *salePriceValueLabel;
/**
 *  收藏人数值
 */
@property (weak, nonatomic) IBOutlet UILabel *collectValueLabel;

/**
 *  收藏图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *collectIconImage;

@end

@implementation CollectionViewCell

-(void)awakeFromNib{
    [self UIConfig];

}

-(void)UIConfig{
    //    self.recommendImage.hidden = YES;
    self.backgroundColor                   = [UIColor whiteColor];

    self.collectImage.contentMode          = UIViewContentModeScaleAspectFill;
    self.productNumberTitleLabel.font      = [UIFont systemFontOfSize:14.0f];
    self.productNumberTitleLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    self.productNumberValueLabel.font      = [UIFont systemFontOfSize:14.0f];
    self.productNumberValueLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    self.salePriceValueLabel.font          = [UIFont systemFontOfSize:13.0f];
    self.salePriceValueLabel.textColor     = [UIColor colorWithHexString:@"#6a6a6a" alpha:1];
    self.collectValueLabel.font            = [UIFont systemFontOfSize:10.0f];
    self.collectValueLabel.textColor       = [UIColor colorWithHexString:@"#999999" alpha:1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginClick)];
    self.salePriceValueLabel.userInteractionEnabled = YES;
    [self.salePriceValueLabel addGestureRecognizer:tap];
}

-(void)resetValueWith:(AVObject*)object{
    NSDictionary *localData = [object objectForKey:@"localData"];
    self.productNumberValueLabel.text = [localData objectForKey:@"productnumber"];
    AVUser *user = [AVUser currentUser];
    if(user){
        self.salePriceValueLabel.text = [NSString stringWithFormat:@"¥ %@",[[localData objectForKey:@"price"] stringValue]];
        [self.collectIconImage setImage:[UIImage imageNamed:@"CollectionViewCell_SaleIcon_Login"]];
        [self.collectValueLabel setTextColor:[UIColor colorWithHexString:@"#3d3d3d" alpha:1]];
    }
    else{
        self.salePriceValueLabel.text = @"登录查看分销价";
        [self.collectIconImage setImage:[UIImage imageNamed:@"CollectionViewCell_SaleIcon_notLogin"]];
        self.collectValueLabel.textColor        = [UIColor colorWithHexString:@"#999999" alpha:1];
    }
    
    NSInteger collectNumber = [[localData objectForKey:Global_ProductCollectNumber] integerValue];
    collectNumber = collectNumber<0?0:collectNumber;
    self.collectValueLabel.text = [NSString stringWithFormat:@"%ld",(long)collectNumber];
    
    [_collectImage downloadImageWithUrl:[localData objectForKey:@"productimg"]];
    
    
}

-(void)loginClick{
    if(![[PersonlInfoManager shareManager] hadLogin]){
        [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_Login];
    }
}

@end
