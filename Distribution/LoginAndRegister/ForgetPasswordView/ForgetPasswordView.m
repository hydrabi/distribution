//
//  ForgetPasswordView.m
//  Distribution
//
//  Created by Hydra on 15/12/29.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "ForgetPasswordView.h"
#import "UIColor+Addition.h"
#import "LoginAndRegisterViewController.h"

#define VerifyCodeInterval 60

@implementation ForgetPasswordView

- (void)drawRect:(CGRect)rect {
    //画线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#c4c4c4" alpha:1].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGPoint startPoint = CGPointMake(12, 75);
    CGPoint endPoint = CGPointMake(CGRectGetWidth(rect)-12, 75);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
}

-(void)awakeFromNib{
    self.titleLabel.font                             = [UIFont systemFontOfSize:20.0];
    self.titleLabel.text                             = @"忘记密码";
    self.titleLabel.textColor                        = [UIColor colorWithHexString:@"#ff4400" alpha:1];

    self.telephoneTextField.preNameLabel.text        = @"手机号";
    self.telephoneTextField.textField.placeholder    = @"请输入您的手机号";
    self.telephoneTextField.textField.delegate       = self;
    self.telephoneTextField.backgroundColor          = [UIColor colorWithHexString:@"f4f4f4" alpha:1];
    self.telephoneTextField.textField.keyboardType   = UIKeyboardTypeNumberPad;

    self.verifyCodeTextField.preNameLabel.text       = @"验证码";
    self.verifyCodeTextField.textField.placeholder   = @"请输入验证码";
    self.verifyCodeTextField.textField.delegate      = self;
    self.verifyCodeTextField.textField.font          = [UIFont systemFontOfSize:14.0f];
    self.verifyCodeTextField.textField.keyboardType  = UIKeyboardTypeNumberPad;

    [self.verifyCodeButton setTitleColor:[UIColor colorWithHexString:@"#5a5a5a" alpha:1] forState:UIControlStateNormal];
    [self.verifyCodeButton setBackgroundColor:[UIColor colorWithHexString:@"f4f4f4" alpha:1]];
    [self.verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verifyCodeButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    self.verifyCodeButton.layer.borderWidth          = 1.0f;
    self.verifyCodeButton.layer.borderColor          = [UIColor colorWithHexString:@"#c4c4c4" alpha:1].CGColor;
    self.verifyCodeButton.layer.cornerRadius         = 5.0f;
    self.verifyCodeButton.clipsToBounds              = YES;
    [self.verifyCodeButton addTarget:self action:@selector(verifyCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.passwordTextField.preNameLabel.text         = @"密码";
    self.passwordTextField.textField.placeholder     = @"请输入新的密码";
    self.passwordTextField.backgroundColor           = [UIColor colorWithHexString:@"f4f4f4" alpha:1];
    self.passwordTextField.textField.delegate        = self;
    self.passwordTextField.textField.secureTextEntry = YES;
    self.passwordTextField.textField.returnKeyType   = UIReturnKeyDone;
    
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishButton setBackgroundColor:[UIColor colorWithHexString:@"ff6f3b" alpha:1]];
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    self.finishButton.layer.cornerRadius           = 5.0f;
    self.finishButton.clipsToBounds                = YES;
    [self.finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

+(instancetype)instanceForgetPasswordView{
    NSArray * arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ForgetPasswordView class]) owner:nil options:nil];
    return [arr objectAtIndex:0];
}

+(CGFloat)forgetPasswordViewHeight{
    return 379.0f;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect nextResponderFrame = CGRectZero;
    if(textField == self.telephoneTextField.textField){
        nextResponderFrame = self.verifyCodeTextField.frame;
    }
    else if(textField == self.verifyCodeTextField.textField){
        nextResponderFrame = self.passwordTextField.frame;
    }
    else if (textField == self.passwordTextField.textField){
        nextResponderFrame = self.finishButton.frame;
    }
    
    if(self.presentViewDelegate && [self.presentViewDelegate respondsToSelector:@selector(resignConstraintWithNextResponderFrame:)]){
        [self.presentViewDelegate resignConstraintWithNextResponderFrame:nextResponderFrame];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //done的返回键点击
    if(textField.returnKeyType == UIReturnKeyDone){
        [self finishButtonClick];
    }
    return YES;
}

#pragma mark - 约束
-(void)makeNormalConstraints{
    if(self.presentViewDelegate && [self.presentViewDelegate isKindOfClass:[LoginAndRegisterViewController class]]){
        LoginAndRegisterViewController *superVC = (LoginAndRegisterViewController*)self.presentViewDelegate;
        [self remakeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(superVC.view.leading).offset(@12);
            make.trailing.equalTo(superVC.view.trailing).offset(@(-12));
            make.centerY.equalTo(superVC.view.centerY);
            make.height.equalTo(@([ForgetPasswordView forgetPasswordViewHeight]));
        }];
    }
    
}

-(void)makeSpecificConstraintsWithTop:(CGFloat)top{
    
    if(self.presentViewDelegate && [self.presentViewDelegate isKindOfClass:[LoginAndRegisterViewController class]]){
        LoginAndRegisterViewController *superVC = (LoginAndRegisterViewController*)self.presentViewDelegate;
        [self remakeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(superVC.view.leading).offset(@12);
            make.trailing.equalTo(superVC.view.trailing).offset(@(-12));
            make.height.equalTo(@([ForgetPasswordView forgetPasswordViewHeight]));
            make.top.equalTo(superVC.view.leading).offset(@(top));
        }];
    }
    
}

#pragma mark - action
/**验证码按钮点击*/
-(void)verifyCodeButtonClick{
    
    if(self.telephoneTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    //获取验证码
    [[PersonlInfoManager shareManager] leanCloudRequestForgetPasswordVerifyCodeWithTelephone:self.telephoneTextField.textField.text completiton:^(BOOL success,NSError *error){
        if(!error){
            [MBProgressHUD showSuccess:@"获取验证码成功！"];
        }
        else{
            [MBProgressHUD showError:@"获取验证码失败！"];
        }
    }];
    
    [self verifyCodeIntervalCountDown];
}

-(void)finishButtonClick{
    if(self.telephoneTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    
    if(self.passwordTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入密码!"];
        return;
    }
    
    if(self.verifyCodeTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入验证码!"];
        return;
    }
    
    [self verifyPrepare];
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
                [_verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_verifyCodeButton setTitleColor:[UIColor colorWithHexString:@"#5a5a5a" alpha:1] forState:UIControlStateNormal];
                _verifyCodeButton.userInteractionEnabled = YES;
            });
        }
        else{
            NSString *str = [NSString stringWithFormat:@"%.2d",interval];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_verifyCodeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",str] forState:UIControlStateNormal];
                [_verifyCodeButton setTitleColor:[UIColor colorWithHexString:@"#b7b7b7" alpha:1] forState:UIControlStateNormal];
                _verifyCodeButton.userInteractionEnabled = NO;
            });
            interval--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 验证操作
//验证准备
-(void)verifyPrepare{
    [self endEditing:YES];
    [self makeNormalConstraints];
    [self verifyRequest];
}

//验证请求
-(void)verifyRequest{
    [[PersonlInfoManager shareManager] leanCloudVerifyForgetPasswordVerifyCodeWith:self.verifyCodeTextField.textField.text
                                                                         telephone:self.telephoneTextField.textField.text
                                                                       newPassword:self.passwordTextField.textField.text
                                                                       completiton:^(BOOL success,NSError *error){
                                                                           
                                                                           [self verifyCompleteWithResult:success];
    }];
}

-(void)verifyCompleteWithResult:(BOOL)result{
    if(result){
        [MBProgressHUD showSuccess:@"密码重置成功，请重新登录！"];
        if(self.presentViewDelegate && [self.presentViewDelegate respondsToSelector:@selector(setDefaultViewType)]){
            [self.presentViewDelegate setDefaultViewType];
        }
        [self clearTextField];
    }
    else{
        [MBProgressHUD showError:@"密码重置失败！"];
        NSLog(@"密码重置失败！");
        self.verifyCodeTextField.textField.text = @"";
    }
    
    
}

-(void)clearTextField{
    self.telephoneTextField.textField.text = @"";
    self.passwordTextField.textField.text = @"";
    self.verifyCodeTextField.textField.text = @"";
}

@end
