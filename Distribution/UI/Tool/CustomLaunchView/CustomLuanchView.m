//
//  CustomLuanchView.m
//  Distribution
//
//  Created by Hydra on 16/3/20.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomLuanchView.h"
#import "UIImage+LaunchImage.h"

#define currentWindow [[UIApplication sharedApplication].windows firstObject]

@interface CustomLuanchView()
@property (nonatomic,strong)UIButton *skipButton;
@property (nonatomic,strong)UIImageView *backgroundImageView;
@property (nonatomic,assign)NSInteger delayTime;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation CustomLuanchView

-(instancetype)initWithDelayTime:(NSInteger)delayTime{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
        self.delayTime = delayTime;
        [self UIConfig];
    }
    return self;
}

-(void)UIConfig{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage getLaunchImage]];
    [self addSubview:self.backgroundImageView];
    
    self.skipButton = [[UIButton alloc] init];
    [self.skipButton setBackgroundColor:[UIColor clearColor]];
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.skipButton];
    
    __weak typeof(self)weakSelf = self;
    [self.backgroundImageView makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.leading);
        make.trailing.equalTo(weakSelf.trailing);
        make.top.equalTo(weakSelf.top);
        make.bottom.equalTo(weakSelf.bottom);
    }];
    
    [self.skipButton makeConstraints:^(MASConstraintMaker *make){
        make.trailing.equalTo(weakSelf.trailing);
        make.top.equalTo(weakSelf.top);
        make.width.equalTo(@70);
        make.height.equalTo(@50);
    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.delayTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

-(void)skipButtonClick{
    [self hide];
}

-(void)show{
    UIView *superView = currentWindow;
    superView.hidden = NO;
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
}


-(void)hide{
    [self.timer invalidate];
    self.timer = nil;
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(self.superview){
            [self removeFromSuperview];
        }
    }];
}

@end
