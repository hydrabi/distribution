//
//  VerifyButtonTextFieldTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "VerifyButtonTextFieldTableViewCell.h"
#import "UIColor+Addition.h"

#define VerifyCodeInterval 60
@implementation VerifyButtonTextFieldTableViewCell

- (void)awakeFromNib {
    self.titleLabel.textColor   = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.titleLabel.font        = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.text        = @"验证码";

    self.textField.textColor    = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
    self.textField.font         = [UIFont systemFontOfSize:16.0f];
    self.textField.placeholder  = @"输入验证码";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    //验证按钮暗淡时颜色为#b7b7b7
    [self.verifyButton setTitleColor:[UIColor colorWithHexString:@"3f3f3f" alpha:1] forState:UIControlStateNormal];
    [self.verifyButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    __weak typeof(self)weakSelf = self;
    self.callBack = ^(BOOL canVerify){
        if(canVerify){
            [weakSelf verifyCodeIntervalCountDown];
        }
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)verifyButtonClick:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(verifyButtonClick:)]){
        [self.delegate verifyButtonClick:self.callBack];
    }
}

#pragma mark - 倒数
/**验证码倒数计时*/
-(void)verifyCodeIntervalCountDown{
    __block int interval = VerifyCodeInterval;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(interval<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_verifyButton setTitleColor:[UIColor colorWithHexString:@"#3f3f3f" alpha:1] forState:UIControlStateNormal];
                _verifyButton.userInteractionEnabled = YES;
            });
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%.2d",interval];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_verifyButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",str] forState:UIControlStateNormal];
                [_verifyButton setTitleColor:[UIColor colorWithHexString:@"#b7b7b7" alpha:1] forState:UIControlStateNormal];
                _verifyButton.userInteractionEnabled = NO;
            });
            interval--;
        }
    });
    dispatch_resume(_timer);
}

@end
