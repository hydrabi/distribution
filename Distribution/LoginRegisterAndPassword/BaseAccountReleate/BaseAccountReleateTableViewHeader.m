//
//  BaseAccountReleateTableViewHeader.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "BaseAccountReleateTableViewHeader.h"
#import "UIColor+Addition.h"
@interface BaseAccountReleateTableViewHeader()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,assign)AccountReleateViewControllerType type;
@end

@implementation BaseAccountReleateTableViewHeader

-(instancetype)initWithType:(AccountReleateViewControllerType)type frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.type = type;
        [self UIConfig];
    }
    return self;
}

-(UILabel*)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"868686" alpha:1];
    }
    return _titleLabel;
}

-(void)UIConfig{
    [self addSubview:self.titleLabel];
    __weak typeof(self)weakSelf = self;
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.leading).offset(12);
        make.trailing.equalTo(weakSelf.trailing).offset(@(-12));
        make.centerX.equalTo(weakSelf.centerX);
        make.centerY.equalTo(weakSelf.centerY);
    }];
    [self resetTitleWithMyType];
    
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)resetTitleWithMyType{
    switch (self.type) {
        case AccountReleateViewControllerType_Login:
        {
            
        }
            break;
        case AccountReleateViewControllerType_forgetPassword:
        {
            self.titleLabel.text = @"我们将发送验证码到您的手机，请注意查收";
        }
            break;
        case AccountReleateViewControllerType_RegisterFirst:
        {
            self.titleLabel.text = @"我们将发送验证码到您的手机，请注意查收";
        }
            break;
        case AccountReleateViewControllerType_RegisterSecond:
        {
            self.titleLabel.text = @"请设置您的账号密码";
        }
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
