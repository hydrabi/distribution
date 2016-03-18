//
//  LoginView.m
//  Distribution
//
//  Created by Hydra on 15/12/29.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "LoginView.h"
#import "UIColor+Addition.h"
#import "LoginAndRegisterViewController.h"
#import "AppDelegate.h"

@interface LoginView()
/**
 *  表示正在加载中
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;
@end

@implementation LoginView

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

-(MBProgressHUD*)progressHUD{
    if(!_progressHUD){
        RootViewController *vc = [AppDelegate getRootController];
        _progressHUD = [[MBProgressHUD alloc] initWithView:vc.view];
        _progressHUD.mode     = MBProgressHUDModeIndeterminate;
        
    }
    return _progressHUD;
}

-(void)awakeFromNib{
    self.titleLabel.font                           = [UIFont systemFontOfSize:20.0];
    self.titleLabel.text                           = @"登陆";
    self.titleLabel.textColor                      = [UIColor colorWithHexString:@"#ff4400" alpha:1];
    
    self.telephoneTextField.preNameLabel.text      = @"手机号";
    self.telephoneTextField.textField.placeholder  = @"请输入您的手机号";
    self.telephoneTextField.textField.delegate     = self;
    self.telephoneTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.telephoneTextField.backgroundColor        = [UIColor colorWithHexString:@"f4f4f4" alpha:1];
    self.telephoneTextField.textField.returnKeyType = UIReturnKeyNext;
    
    
    self.passwordTextField.preNameLabel.text       = @"密码";
    self.passwordTextField.textField.placeholder   = @"请输入密码";
    self.passwordTextField.textField.secureTextEntry = YES;
    self.passwordTextField.backgroundColor         = [UIColor colorWithHexString:@"f4f4f4" alpha:1];
    self.passwordTextField.textField.delegate      = self;
    self.passwordTextField.textField.returnKeyType = UIReturnKeyDone;
    
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishButton setBackgroundColor:[UIColor colorWithHexString:@"ff6f3b" alpha:1]];
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    self.finishButton.layer.cornerRadius           = 5.0f;
    self.finishButton.clipsToBounds                = YES;
    [self.finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registerButton setTitleColor:[UIColor colorWithHexString:@"8d8d8d" alpha:1] forState:UIControlStateNormal];
    
    [self.forgetPasswordButton setTitleColor:[UIColor colorWithHexString:@"8d8d8d" alpha:1] forState:UIControlStateNormal];
    
}

+(instancetype)instanceLoginView{
    NSArray * arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LoginView class]) owner:nil options:nil];
    return [arr objectAtIndex:0];
}

+(CGFloat)loginViewHeight{
    return 337.0f;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect nextResponderFrame = CGRectZero;
    if(textField == self.telephoneTextField.textField){
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

#pragma mark - 约束修改
-(void)makeNormalConstraints{
    if(self.presentViewDelegate && [self.presentViewDelegate isKindOfClass:[LoginAndRegisterViewController class]]){
        LoginAndRegisterViewController *superVC = (LoginAndRegisterViewController*)self.presentViewDelegate;
        [self remakeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(superVC.view.leading).offset(@12);
            make.trailing.equalTo(superVC.view.trailing).offset(@(-12));
            make.centerY.equalTo(superVC.view.centerY);
            make.height.equalTo(@([LoginView loginViewHeight]));
        }];
    }
    
}

-(void)makeSpecificConstraintsWithTop:(CGFloat)top{
    
    if(self.presentViewDelegate && [self.presentViewDelegate isKindOfClass:[LoginAndRegisterViewController class]]){
        LoginAndRegisterViewController *superVC = (LoginAndRegisterViewController*)self.presentViewDelegate;
        [self remakeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(superVC.view.leading).offset(@12);
            make.trailing.equalTo(superVC.view.trailing).offset(@(-12));
            make.height.equalTo(@([LoginView loginViewHeight]));
            make.top.equalTo(superVC.view.leading).offset(@(top));
        }];
    }
    
}

#pragma mark - 完成按钮点击
-(void)finishButtonClick{
    if(self.telephoneTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    
    if(self.passwordTextField.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入密码!"];
        return;
    }
    
    [self loginPrepare];
}

-(void)loginPrepare{
    
    [self endEditing:YES];
    [self makeNormalConstraints];
    
    
    [self loginRequest];
}

-(void)loginRequest{
    
    
    [[PersonlInfoManager shareManager] loginWithTelephoneNumber:self.telephoneTextField.textField.text password:self.passwordTextField.textField.text completiton:^(BOOL success){
        [self loginCompleteWithResult:success];
    }];
    
    
    
    
}

-(void)loginCompleteWithResult:(BOOL)result{
    if(self.presentViewDelegate && [self.presentViewDelegate respondsToSelector:@selector(operationCompetition)]){
        [self.presentViewDelegate operationCompetition];
    }
    if(result){
        [MBProgressHUD showSuccess:@"登陆成功"];
    }
    else{
        [MBProgressHUD showError:@"登陆失败"];
    }
    
    [self clearTextField];
}

-(void)clearTextField{
    self.telephoneTextField.textField.text = @"";
    self.passwordTextField.textField.text = @"";
}

@end
