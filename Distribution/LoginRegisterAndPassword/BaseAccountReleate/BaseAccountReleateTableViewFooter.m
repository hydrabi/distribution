//
//  BaseAccountReleateTableViewFooter.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "BaseAccountReleateTableViewFooter.h"
#import "UIColor+Addition.h"
@interface BaseAccountReleateTableViewFooter()
@property (nonatomic,assign)AccountReleateViewControllerType type;
@end

@implementation BaseAccountReleateTableViewFooter

-(instancetype)initWithType:(AccountReleateViewControllerType)type frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.type = type;
        self.userInteractionEnabled = YES;
        [self UIConfig];
    }
    return self;
}

-(UIButton*)mainButton{
    if(!_mainButton){
        _mainButton = [[UIButton alloc] init];
        [_mainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_mainButton setBackgroundColor:[UIColor colorWithHexString:@"ff5000" alpha:1]];
        _mainButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _mainButton.layer.cornerRadius = 5.0f;
        _mainButton.clipsToBounds = YES;
    }
    return _mainButton;
}

-(UIButton*)subButton{
    if(!_subButton){
        _subButton = [[UIButton alloc] init];
        [_subButton setTitleColor:[UIColor colorWithHexString:@"9b9ba3" alpha:1] forState:UIControlStateNormal];
        [_subButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        _subButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _subButton;
}

-(void)UIConfig{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.mainButton];
    [self addSubview:self.subButton];
    __weak typeof(self)weakSelf = self;
    [self.mainButton makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.leading).offset(12);
        make.trailing.equalTo(weakSelf.trailing).offset(@(-12));
        make.top.equalTo(weakSelf.top).offset(@20);
        make.centerX.equalTo(weakSelf.centerX);
        make.height.equalTo(@44);
    }];

    [self.subButton makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.mainButton.bottom);
        make.height.equalTo(@40);
        make.trailing.equalTo(weakSelf.mainButton.trailingMargin);
    }];
    [self resetTitleWithMyType];
}

-(void)resetTitleWithMyType{
    switch (self.type) {
        case AccountReleateViewControllerType_Login:
        {
            [self.mainButton setTitle:@"点击登录" forState:UIControlStateNormal];
            [self.subButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
            self.subButton.hidden = NO;
        }
            break;
        case AccountReleateViewControllerType_forgetPassword:
        {
            [self.mainButton setTitle:@"重置" forState:UIControlStateNormal];
            [self.subButton setTitle:@"" forState:UIControlStateNormal];
            self.subButton.hidden = YES;
        }
            break;
        case AccountReleateViewControllerType_RegisterFirst:
        {
            [self.mainButton setTitle:@"下一步" forState:UIControlStateNormal];
            [self.subButton setTitle:@"" forState:UIControlStateNormal];
            self.subButton.hidden = YES;
        }
            break;
        case AccountReleateViewControllerType_RegisterSecond:
        {
            [self.mainButton setTitle:@"完成" forState:UIControlStateNormal];
            [self.subButton setTitle:@"" forState:UIControlStateNormal];
            self.subButton.hidden = YES;
        }
            break;
        case AccountReleateViewControllerType_adviceFeedBack:
        {
            [self.mainButton setTitle:@"点击提交" forState:UIControlStateNormal];
            [self.subButton setTitle:@"" forState:UIControlStateNormal];
            self.subButton.hidden = YES;
        }
            break;
        default:
            break;
    }
}

@end
