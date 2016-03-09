//
//  LoginView.h
//  Distribution
//
//  Created by Hydra on 15/12/29.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRCustomTextField.h"
#import "PresentViewDelegate.h"
#import "UIView+Addition.h"
@interface LoginView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet LRCustomTextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet LRCustomTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) id <presentViewDelegate> presentViewDelegate;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
+(instancetype)instanceLoginView;

+(CGFloat)loginViewHeight;

-(void)makeSpecificConstraintsWithTop:(CGFloat)top;

-(void)makeNormalConstraints;
@end
