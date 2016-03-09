//
//  PersonalMainOrderCellButton.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainOrderCellButton.h"
#import "UIColor+Addition.h"
#pragma mark - 按钮字体
static const CGFloat customTabBarButtonFontSize = 14.0f;
static const CGFloat imageTopOffset = 10.0f;
static const CGFloat imageWidthAndHeiht = 22.0f;
static const CGFloat titleBottomOffset = 5.0f;

#pragma mark - 按钮标题
static NSString *PersonalMainOrderCellButtonNotPayTitle = @"未付款";
static NSString *PersonalMainOrderCellButtonNotDeliverTitle  = @"待发货";
static NSString *PersonalMainOrderCellButtonHadDeliverTitle  = @"已发货";
static NSString *PersonalMainOrderCellButtonReturn = @"退货/退款";

#pragma mark - 图片名称
static NSString *PersonalMainOrderCellButtonNotPayImage              = @"personalOrderCell_notPay";
static NSString *PersonalMainOrderCellButtonNotDeliverImage           = @"personalOrderCell_notDeliver";
static NSString *PersonalMainOrderCellButtonHadDeliverImage           = @"personalOrderCell_hadDeliver";
static NSString *PersonalMainOrderCellButtonReturnImage          = @"personalOrderCell_return";

#pragma mark - 图片比例
static CGFloat customTabBarButtonImagePer = 0.7;

@interface PersonalMainOrderCellButton()

@property (nonatomic,assign)PersonalMainOrderCellButtonType type;

@end

@implementation PersonalMainOrderCellButton

-(instancetype)initWithButtonType:(PersonalMainOrderCellButtonType)type{
    self = [super init];
    if(self){
        self.type = type;
        [self configUI];
    }
    return self;
}

#pragma mark - 配置UI
/**配置UI*/
-(void)configUI{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont systemFontOfSize:customTabBarButtonFontSize];
    self.adjustsImageWhenHighlighted = NO;
    [self setTitleColor:[UIColor colorWithHexString:@"9f9f9f" alpha:1] forState:UIControlStateNormal];
    [self configAttribute];
}

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸
// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * (1 - customTabBarButtonImagePer);
    CGFloat titleY = contentRect.size.height - titleHeight-titleBottomOffset;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (CGRectGetWidth(contentRect)-imageWidthAndHeiht)/2;
    CGFloat imageY = imageTopOffset;
    CGFloat imageWidth = imageWidthAndHeiht;
    CGFloat imageHeight = imageWidthAndHeiht;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

/**根据不同的状态切换按钮的属性*/
-(void)configAttribute{
    NSString *imageName;
    switch (self.type) {
            //代付款
        case PersonalMainOrderCellButtonType_notPay:
        {
            [self setTitle:[NSString stringWithString:PersonalMainOrderCellButtonNotPayTitle] forState:UIControlStateNormal];
            imageName = PersonalMainOrderCellButtonNotPayImage;
        }
            break;
            //代发货
        case PersonalMainOrderCellButtonType_notDeliver:
        {
            [self setTitle:[NSString stringWithString:PersonalMainOrderCellButtonNotDeliverTitle] forState:UIControlStateNormal];
            imageName = PersonalMainOrderCellButtonNotDeliverImage;
        }
            break;
            //已发货
        case PersonalMainOrderCellButtonType_hadDeliver:
        {
            [self setTitle:[NSString stringWithString:PersonalMainOrderCellButtonHadDeliverTitle] forState:UIControlStateNormal];
            imageName = PersonalMainOrderCellButtonHadDeliverImage;
            
        }
            break;
            //退货
        case PersonalMainOrderCellButtonType_Return:
        {
            [self setTitle:[NSString stringWithString:PersonalMainOrderCellButtonReturn] forState:UIControlStateNormal];
            imageName = PersonalMainOrderCellButtonReturnImage;
        }
            break;
            
        default:
            break;
    }
    if(imageName.length>0){
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}

@end
