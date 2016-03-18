//
//  ClassifyViewTableViewHeader.m
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ClassifyViewTableViewHeader.h"
#import "PersonalMacro.h"
#import "PersonlInfoManager.h"
#import "ImageManager.h"
#define logoImageWidthAndHeight 80.0f

@interface ClassifyViewTableViewHeader()

@property (nonatomic,strong)UIImageView *backgroundImage;

@property (nonatomic,strong)UIImageView *logoImage;

@end

@implementation ClassifyViewTableViewHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIConfig];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)UIConfig{
    self.backgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
    self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backgroundImage];
    [self.backgroundImage setImage:[UIImage imageNamed:@"classify_background"]];
    [self.backgroundImage makeConstraints:^(MASConstraintMaker* make){
        make.leading.equalTo(self.leading).offset(0);
        make.trailing.equalTo(self.trailing).offset(0);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
    
    self.logoImage = [[UIImageView alloc] init];
    [self addSubview:self.logoImage];
    self.logoImage.layer.cornerRadius = logoImageWidthAndHeight/2;
    self.logoImage.clipsToBounds = YES;
    self.logoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.logoImage addGestureRecognizer:tap];
    [self.logoImage makeConstraints:^(MASConstraintMaker* make){
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(self.centerY);
        make.width.and.height.equalTo(@(logoImageWidthAndHeight));
    }];
    
    [self loginStatusChange];
}

-(void)loginStatusChange{
    if([[PersonlInfoManager shareManager] hadLogin]){
        AVUser *user = [AVUser currentUser];
        [self.logoImage setImage:[ImageManager userHeadImageWithImageName:user]];
    }
    else{
        [self.logoImage setImage:[UIImage imageNamed:@"personalHeader_headDefault"]];
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    CGRect rect = self.frame;
    rect = self.backgroundImage.frame;
    if(![[PersonlInfoManager shareManager] hadLogin]){
        //未登录，弹出登录框
        [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_Login];
    }
}

@end
