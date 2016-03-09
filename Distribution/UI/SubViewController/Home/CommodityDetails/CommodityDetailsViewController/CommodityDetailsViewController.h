//
//  CommodityDetailsViewController.h
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityDetailsViewController : UIViewController

/**
 *  购买按钮
 */
@property (weak,nonatomic)IBOutlet UIButton *purchaseButton;

/**
 *  初始化的同时传入商品id
 *
 *  @param object 商品详情
 *
 *  @return 商品详情实例
 */
-(instancetype)initWithObject:(AVObject *)object;

@end
