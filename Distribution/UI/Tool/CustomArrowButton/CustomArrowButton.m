//
//  CustomArrowButton.m
//  Distribution
//
//  Created by Hydra on 15/12/18.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#define DEGREES_TO_RADIANS(x) (x)/180.0*M_PI
#define RADIANS_TO_DEGREES(x) (x)/M_PI*180.0

#import "CustomArrowButton.h"
#import "NSString+Addition.h"
#import "CommonMacro.h"
#import "UIColor+Addition.h"

const static CGFloat imageOffset = -10.0f;

@interface CustomArrowButton()
@property (nonatomic,assign)NavTabBarButtonType barButtonType;
@property (nonatomic,strong)UIView *backGroundView;
@property (nonatomic,strong)UIImageView *arrowImageView;
@property (nonatomic,strong)UILabel *bgTitleLabel;
@end

@implementation CustomArrowButton

-(instancetype)initWithFrame:(CGRect)frame barButtonType:(NavTabBarButtonType)type{
    self = [super initWithFrame:frame];
    if(self){
        self.barButtonType = type;
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    self.backGroundView = [[UIView alloc] init];
    self.backGroundView.userInteractionEnabled = NO;
    [self addSubview:self.backGroundView];
    
    self.bgTitleLabel = [[UILabel alloc] init];
    [self.bgTitleLabel setFont:[UIFont systemFontOfSize:BUTTONTITLEFONT]];
    [self.bgTitleLabel setTextColor:TAB_BAR_BUTTON_NORMAL_TITLE_COLOR];
    [self.bgTitleLabel setText:[self getTitleWithType:self.barButtonType]];
    [self.backGroundView addSubview:self.bgTitleLabel];
    
    self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomTabBarButton_Arrow"]];
    self.arrowImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
    [self.backGroundView addSubview:self.arrowImageView];
    
    //分类出现箭头,其它隐藏
    if(self.barButtonType == NavTabBarButtonType_classify){
        self.arrowImageView.hidden = NO;
    }
    else{
        self.arrowImageView.hidden = YES;
    }
    
    [self constraintsConfig];
    
}

-(void)constraintsConfig{
    __weak typeof(self)weakSelf = self;
    [self.backGroundView makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.centerX);
        make.top.equalTo(weakSelf.top);
        make.bottom.equalTo(weakSelf.bottom);
    }];
    
    [self.bgTitleLabel makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(_backGroundView.leading);
        make.top.equalTo(_backGroundView.top);
        make.bottom.equalTo(_backGroundView.bottom);
        if(weakSelf.barButtonType == NavTabBarButtonType_classify){
            make.trailing.equalTo(_arrowImageView.leading).offset(@(imageOffset));
        }
        else{
            make.trailing.equalTo(_backGroundView.trailing);
        }
        
    }];
    
    if(weakSelf.barButtonType == NavTabBarButtonType_classify){
        [self.arrowImageView makeConstraints:^(MASConstraintMaker *make){
            make.trailing.equalTo(_backGroundView.trailing);
            make.centerY.equalTo(_backGroundView.centerY);
        }];
    }
    
}

-(void)modifyTextColorWithSelectedOrNot:(BOOL)selected{
    if(selected){
        [self.bgTitleLabel setTextColor:TAB_BAR_BUTTON_SELECTED_TITLE_COLOR];
    }
    else{
        [self.bgTitleLabel setTextColor:TAB_BAR_BUTTON_NORMAL_TITLE_COLOR];
    }
}

/**获取指定类型的title*/
-(NSString *)getTitleWithType:(NavTabBarButtonType)type{
    NSString *result = @"";
    switch (type) {
        case NavTabBarButtonType_classify:
        {
            result = @"分类";
        }
            break;
        case NavTabBarButtonType_new:
        {
            result = @"上新";
        }
            break;
        case NavTabBarButtonType_approve:
        {
            result = @"特批";
        }
            break;
        case NavTabBarButtonType_presell:
        {
            result = @"预售";
        }
            break;
        case NavTabBarButtonType_all:
        {
            result = @"全部";
        }
            break;
            
        default:
            break;
    }
    return result;
}

-(void)transformRotationAbove:(BOOL)above{
    CGFloat degree = 0;
    if(above){
        degree = 180.0f;
    }
    else{
        degree = 0.0f;
    }
    self.arrowImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degree));
}

@end
