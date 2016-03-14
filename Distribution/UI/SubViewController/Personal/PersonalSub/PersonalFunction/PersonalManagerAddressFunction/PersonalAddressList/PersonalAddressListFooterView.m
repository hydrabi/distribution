//
//  PersonalAddressListFooterView.m
//  Distribution
//
//  Created by Hydra on 16/3/12.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAddressListFooterView.h"
#import "UIColor+Addition.h"
#import "PersonalManagerAddressMacro.h"
@interface PersonalAddressListFooterView()
@property (nonatomic,strong)UIImageView *backgroundImage;
@property (nonatomic,strong)UIView *titleBackgroundView;
@property (nonatomic,strong)UIImageView *plusImage;
@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation PersonalAddressListFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIConfig];
    }
    return self;
}

#pragma mark - 属性

-(UIImageView*)backgroundImage{
    if(!_backgroundImage){
        _backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalAddresetListFooterBackground"]];
    }
    return _backgroundImage;
}

-(UIView*)titleBackgroundView{
    if(!_titleBackgroundView){
        _titleBackgroundView = [[UIView alloc] init];
        _titleBackgroundView.backgroundColor = [UIColor clearColor];
    }
    return _titleBackgroundView;
}

-(UIImageView*)plusImage{
    if(!_plusImage){
        _plusImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalAddresetListFooterPlus"]];
    }
    return _plusImage;
}

-(UILabel*)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = PersonalAddrestListFooterTitleColor;
        _titleLabel.font = PersonalAddrestListFooterTitleFont;
        _titleLabel.text = PersonalAddrestListFooterTitle;
    }
    return _titleLabel;
}

-(void)UIConfig{
    [self addSubview:self.backgroundImage];
    [self.titleBackgroundView addSubview:self.plusImage];
    [self.titleBackgroundView addSubview:self.titleLabel];
    [self addSubview:self.titleBackgroundView];
    [self constraintsConfig];
}

-(void)constraintsConfig{
    __weak typeof(self)weakSelf = self;
    [self.backgroundImage makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.leading).offset(0);
        make.trailing.equalTo(weakSelf.trailing).offset(0);
        make.top.equalTo(weakSelf.top).offset(0);
        make.bottom.equalTo(weakSelf.bottom).offset(0);
    }];
    
    [self.titleBackgroundView makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.centerX);
        make.centerY.equalTo(weakSelf.centerY);
    }];
    
    [self.plusImage makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.titleBackgroundView.leading);
        make.top.equalTo(weakSelf.titleBackgroundView.top);
        make.bottom.equalTo(weakSelf.titleBackgroundView.bottom);
        make.width.and.height.equalTo(@(PersonalAddrestListFooterPlusImageWidthAndHeight));
        make.trailing.equalTo(weakSelf.titleLabel.leading).offset(0);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make){
        make.trailing.equalTo(weakSelf.titleBackgroundView.trailing);
        make.top.equalTo(weakSelf.titleBackgroundView.top);
        make.bottom.equalTo(weakSelf.titleBackgroundView.bottom);
    }];
}

@end
