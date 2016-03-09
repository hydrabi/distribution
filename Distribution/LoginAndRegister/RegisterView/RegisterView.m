//
//  RegisterView.m
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "RegisterView.h"
#import "UIColor+Addition.h"
#import "LoginAndRegisterViewController.h"
#import "AppDelegate.h"

#define VerifyCodeInterval 60

@implementation RegisterView

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
    self.titleLabel.font                                       = [UIFont systemFontOfSize:20.0];
    self.titleLabel.text                                       = @"注册";
    self.titleLabel.textColor                                  = [UIColor colorWithHexString:@"#ff4400" alpha:1];

    self.telephoneTextField.preNameLabel.text                  = @"手机号";
    self.telephoneTextField.textField.placeholder              = @"请输入您的手机号";
    self.telephoneTextField.textField.delegate                 = self;
    self.telephoneTextField.backgroundColor                    = [UIColor colorWithHexString:@"f4f4f4" alpha:1];
    self.telephoneTextField.textField.keyboardType             = UIKeyboardTypeNumberPad;
    self.telephoneTextField.textField.returnKeyType            = UIReturnKeyNext;

    self.verifyCodeTextField.preNameLabel.text                 = @"验证码";
    self.verifyCodeTextField.textField.placeholder             = @"请输入验证码";
    self.verifyCodeTextField.textField.delegate                = self;
    self.verifyCodeTextField.textField.font                    = [UIFont systemFontOfSize:14];
    self.verifyCodeTextField.textField.keyboardType            = UIKeyboardTypeNumberPad;
    self.verifyCodeTextField.textField.returnKeyType           = UIReturnKeyDone;

    [self.verifyCodeButton setTitleColor:[UIColor colorWithHexString:@"#5a5a5a" alpha:1] forState:UIControlStateNormal];
    [self.verifyCodeButton setBackgroundColor:[UIColor colorWithHexString:@"f4f4f4" alpha:1]];
    [self.verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verifyCodeButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    self.verifyCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.verifyCodeButton.layer.borderWidth                    = 1.0f;
    self.verifyCodeButton.layer.borderColor                    = [UIColor colorWithHexString:@"#c4c4c4" alpha:1].CGColor;
    self.verifyCodeButton.layer.cornerRadius                   = 5.0f;
    self.verifyCodeButton.clipsToBounds                        = YES;
    [self.verifyCodeButton addTarget:self action:@selector(verifyCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.passwordTextField.preNameLabel.text                   = @"密码";
    self.passwordTextField.textField.placeholder               = @"请输入密码";
    self.passwordTextField.backgroundColor                     = [UIColor colorWithHexString:@"f4f4f4" alpha:1];
    self.passwordTextField.textField.delegate                  = self;
    self.passwordTextField.textField.secureTextEntry           = YES;
    self.passwordTextField.textField.returnKeyType             = UIReturnKeyNext;

    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishButton setBackgroundColor:[UIColor colorWithHexString:@"ff6f3b" alpha:1]];
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    self.finishButton.layer.cornerRadius           = 5.0f;
    self.finishButton.clipsToBounds                = YES;
    [self.finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

+(instancetype)instanceRegisterView{
    NSArray * arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RegisterView class]) owner:nil options:nil];
    return [arr objectAtIndex:0];
}

+(CGFloat)registerViewHeight{
    return 379.0f;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self skipToTheNextResponderWithTextField:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType == UIReturnKeyNext){
        [self skipToTheNextResponderWithTextField:self.verifyCodeTextField.textField];
        [self.verifyCodeTextField.textField becomeFirstResponder];
    }
    return YES;
}

-(void)skipToTheNextResponderWithTextField:(UITextField *)textField{
    CGRect nextResponderFrame = CGRectZero;
    if(textField == self.telephoneTextField.textField){
        nextResponderFrame = self.verifyCodeTextField.frame;
    }
    else if(textField == self.passwordTextField.textField){
        nextResponderFrame = self.verifyCodeTextField.frame;
    }
    else if (textField == self.verifyCodeTextField.textField){
        nextResponderFrame = self.finishButton.frame;
    }
    
    if(self.presentViewDelegate && [self.presentViewDelegate respondsToSelector:@selector(resignConstraintWithNextResponderFrame:)]){
        [self.presentViewDelegate resignConstraintWithNextResponderFrame:nextResponderFrame];
    }
}

#pragma mark - 约束
-(void)makeNormalConstraints{
    if(self.presentViewDelegate && [self.presentViewDelegate isKindOfClass:[LoginAndRegisterViewController class]]){
        LoginAndRegisterViewController *superVC = (LoginAndRegisterViewController*)self.presentViewDelegate;
        [self remakeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(superVC.view.leading).offset(@12);
            make.trailing.equalTo(superVC.view.trailing).offset(@(-12));
            make.centerY.equalTo(superVC.view.centerY);
            make.height.equalTo(@([RegisterView registerViewHeight]));
        }];
    }
    
}

-(void)makeSpecificConstraintsWithTop:(CGFloat)top{
    
    if(self.presentViewDelegate && [self.presentViewDelegate isKindOfClass:[LoginAndRegisterViewController class]]){
        LoginAndRegisterViewController *superVC = (LoginAndRegisterViewController*)self.presentViewDelegate;
        [self remakeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(superVC.view.leading).offset(@12);
            make.trailing.equalTo(superVC.view.trailing).offset(@(-12));
            make.height.equalTo(@([RegisterView registerViewHeight]));
            make.top.equalTo(superVC.view.leading).offset(@(top));
        }];
    }
    
}

#pragma mark - action
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
    
    [self registerPrepare];
}

/**验证码按钮点击*/
-(void)verifyCodeButtonClick{
    
    if(self.telephoneTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    
    if(self.passwordTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入密码!"];
        return;
    }
    
    //获取验证码
    [[PersonlInfoManager shareManager] leanCloudRequestVerifyCodeWithTelephone:self.telephoneTextField.textField.text password:self.passwordTextField.textField.text completiton:^(BOOL success,NSError *error){
        if(!error){
            [MBProgressHUD showSuccess:@"获取验证码成功！"];
        }
        else{
            [MBProgressHUD showError:@"获取验证码失败！"];
        }
    }];
    
    [self verifyCodeIntervalCountDown];
}

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

#pragma mark - register
-(void)registerPrepare{
    [self endEditing:YES];
    [self makeNormalConstraints];
    [self registerRequest];
}

//注册请求
-(void)registerRequest{
    //leanClound验证验证码
    [[PersonlInfoManager shareManager] leanCloudVerifyVerifyCodeWith:self.verifyCodeTextField.textField.text telephone:self.telephoneTextField.textField.text completiton:^(BOOL success,NSError *error){
        if(success){
            //成功后环信注册
            [[PersonlInfoManager shareManager] registerWithTelephoneNumber:self.telephoneTextField.textField.text password:self.passwordTextField.textField.text completiton:^(BOOL success){
                [self registerCompleteWithResult:success];
            }];
        }
        else{
            [MBProgressHUD showError:@"验证码验证失败！"];
            NSLog(@"验证码验证失败！");
        }

    }];
    

    //成功后环信注册
//    [[PersonlInfoManager shareManager] registerWithTelephoneNumber:self.telephoneTextField.textField.text password:self.passwordTextField.textField.text completiton:^(BOOL success){
//        [self registerCompleteWithResult:success];
//    }];
}

-(void)registerCompleteWithResult:(BOOL)result{
    if(result){
        [MBProgressHUD showSuccess:@"注册成功"];
        if(self.presentViewDelegate && [self.presentViewDelegate respondsToSelector:@selector(operationCompetition)]){
            [self.presentViewDelegate operationCompetition];
        }
        [self clearTextField];
    }
    else{
        [MBProgressHUD showError:@"注册失败"];
    }
    
}

-(void)clearTextField{
    self.telephoneTextField.textField.text = @"";
    self.passwordTextField.textField.text = @"";
    self.verifyCodeTextField.textField.text = @"";
}

@end
