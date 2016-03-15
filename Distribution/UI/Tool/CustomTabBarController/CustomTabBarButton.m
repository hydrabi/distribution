//
//  CustomTabBarButton.m
//  FoodDelivered
//
//  Created by hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import "CustomTabBarButton.h"
#import "UIColor+Addition.h"

#pragma mark - 按钮字体
static const CGFloat customTabBarButtonFontSize = 12.0f;
static const CGFloat imageLeftOffset = 2.0f;
static const CGFloat imageTopOffset = 5.0f;
static const CGFloat badgeImageHeightAndWidth = 11.0f;
static const CGFloat badgeImageTopOffset = 5.0f;
static const CGFloat badgeImageCenterXOffset = 18.0f;

#pragma mark - 按钮标题
static NSString *customTabBarButtonHomeTitle     = @"首页";
static NSString *customTabBarButtonClassifyTitle = @"分类";
//static NSString *customTabBarButtonCollectTitle  = @"收藏";
static NSString *customTabBarButtonDiscoverTitle  = @"发现";
static NSString *customTabBarButtonShoppingCarTitle = @"购物车";
static NSString *customTabBarButtonPersonalTitle = @"个人";

#pragma mark - 图片名称
static NSString *customTabbarButtonHomeImage_selected     = @"CustomTabBarHome_Selected";
static NSString *customTabbarButtonHomeImage              = @"CustomTabBarHome_UnSelected";
//static NSString *customTabbarButtonCollectImage_selected  = @"CustomTabBarCollect_Selected";
//static NSString *customTabbarButtonCollectImage           = @"CustomTabBarCollect_UnSelected";
static NSString *customTabbarButtonClassifyImage_selected = @"CustomTabBarClassify_Selected";
static NSString *customTabbarButtonClassifyImage_unSelected = @"CustomTabBarClassify_UnSelected";
static NSString *customTabbarButtonShoppingCarImage_selected = @"CustomTabBarShoppingCar_Selected";
static NSString *customTabbarButtonShoppingCarImage_unSelected = @"CustomTabBarShoppingCar_UnSelected";
static NSString *customTabbarButtonDiscoverImage_selected  = @"CustomTabBarDiscover_Selected";
static NSString *customTabbarButtonDiscoverImage           = @"CustomTabBarDiscover_UnSelected";
static NSString *customTabbarButtonPersonalImage_selected = @"CustomTabBarPersonal_Selected";
static NSString *customTabbarButtonPersonalImage          = @"CustomTabBarPersonal_UnSelected";

#pragma mark - 图片比例
static CGFloat customTabBarButtonImagePer = 0.7;

#pragma mark - 按钮字体
#define customTabbarButtonTitleColor [UIColor colorWithHexString:@"#7c7c7c" alpha:1]
#define customTabbarButtonTitleSelectedColor [UIColor colorWithHexString:@"#ff6f3b" alpha:1]

@interface CustomTabBarButton()

/**
 *  按钮类型
 */
@property (nonatomic,assign) CustomTabBarButtonType type;
/**
 *  标记提示image
 */
@property (nonatomic,strong) UIImageView *badgeImage;
@end

@implementation CustomTabBarButton

-(instancetype)initWithButtonType:(CustomTabBarButtonType)type{
    self = [super init];
    if(self){
        self.type = type;
        [self configUI];
        [self addBadgeObserver];
    }
    return self;
}

#pragma mark - badge标记展示与隐藏
-(void)addBadgeObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeStatusShow:) name:NSNotificationKey_BadgeShow object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(badgeStatusHide:) name:NSNotificationKey_BadgeHide object:nil];
}

//展示指定button类型的badge
-(void)badgeStatusShow:(NSNotification*)noti{
    NSDictionary *userInfo = noti.userInfo;
    CustomTabBarButtonType type = (CustomTabBarButtonType)[[userInfo objectForKey:NSNotificationUserInfoKey_BadgeButtonType] integerValue];
    if(type == self.type){
        self.badgeImage.hidden = NO;
    }
}
//隐藏指定button类型的badge
-(void)badgeStatusHide:(NSNotification*)noti{
    NSDictionary *userInfo = noti.userInfo;
    CustomTabBarButtonType type = [[userInfo objectForKey:NSNotificationUserInfoKey_BadgeButtonType] integerValue];
    if(type == self.type){
        self.badgeImage.hidden = YES;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸
// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * (1 - customTabBarButtonImagePer);
    CGFloat titleY = contentRect.size.height - titleHeight-3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = imageLeftOffset;
    CGFloat imageY = imageTopOffset;
    CGFloat imageWidth = contentRect.size.width-imageLeftOffset*2;
    CGFloat imageHeight = contentRect.size.height * customTabBarButtonImagePer-imageTopOffset*2;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark - 配置UI
/**配置UI*/
-(void)configUI{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.font = [UIFont systemFontOfSize:customTabBarButtonFontSize];
    self.adjustsImageWhenHighlighted = NO;
    [self configAttributeWithHighlighted:NO];
    [self badgeConfig];
}

//标记提示配置
-(void)badgeConfig{
    if(self.badgeImage == nil){
        self.badgeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomTabBar_badge"]];
        [self addSubview:self.badgeImage];
        self.badgeImage.hidden = YES;
    }
    
    [self.badgeImage makeConstraints:^(MASConstraintMaker*make){
        make.width.and.height.equalTo(@(badgeImageHeightAndWidth));
        make.top.equalTo(self.top).offset(@(badgeImageTopOffset));
        make.centerX.equalTo(self.centerX).offset(@(badgeImageCenterXOffset));
    }];
}

/**根据不同的状态切换按钮的属性*/
-(void)configAttributeWithHighlighted:(BOOL)highlighted{
    NSString *imageName;
    UIColor *titleColor = customTabbarButtonTitleColor;
    switch (self.type) {
        //首页
        case CustomTabBarButtonType_home:
        {
            [self setTitle:[NSString stringWithString:customTabBarButtonHomeTitle] forState:UIControlStateNormal];
            if(highlighted){
                imageName = customTabbarButtonHomeImage_selected;
                titleColor = customTabbarButtonTitleSelectedColor;
            }
            else{
                imageName = customTabbarButtonHomeImage;
            }
        }
            break;
        //分类
        case CustomTabBarButtonType_classify:
        {
            [self setTitle:[NSString stringWithString:customTabBarButtonClassifyTitle] forState:UIControlStateNormal];
            if(highlighted){
                imageName = customTabbarButtonClassifyImage_selected;
                titleColor = customTabbarButtonTitleSelectedColor;
            }
            else{
                imageName = customTabbarButtonClassifyImage_unSelected;
            }
        }
            break;
            //购物车
        case CustomTabBarButtonType_shoppingCar:
        {
            [self setTitle:[NSString stringWithString:customTabBarButtonShoppingCarTitle] forState:UIControlStateNormal];
            if(highlighted){
                imageName = customTabbarButtonShoppingCarImage_selected;
                titleColor = customTabbarButtonTitleSelectedColor;
            }
            else{
                imageName = customTabbarButtonShoppingCarImage_unSelected;
            }
        }
            break;
        //客服
        case CustomTabBarButtonType_discover:
        {
            [self setTitle:[NSString stringWithString:customTabBarButtonDiscoverTitle] forState:UIControlStateNormal];
            if(highlighted){
                imageName = customTabbarButtonDiscoverImage_selected;
                titleColor = customTabbarButtonTitleSelectedColor;
            }
            else{
                imageName = customTabbarButtonDiscoverImage;
            }
        }
            break;
        //个人
        case CustomTabBarButtonType_personal:
        {
            [self setTitle:[NSString stringWithString:customTabBarButtonPersonalTitle] forState:UIControlStateNormal];
            if(highlighted){
                imageName = customTabbarButtonPersonalImage_selected;
                titleColor = customTabbarButtonTitleSelectedColor;
            }
            else{
                imageName = customTabbarButtonPersonalImage;
            }
        }
            break;
            
        default:
            break;
    }
    if(imageName.length>0){
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

#pragma mark - 

-(CustomTabBarButtonType)getButtonType{
    return self.type;
}
@end
