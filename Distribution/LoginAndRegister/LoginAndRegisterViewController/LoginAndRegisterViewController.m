//
//  LoginAndRegisterViewController.m
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "LoginNavigationControllerViewController.h"
#import "UIColor+Addition.h"
#import "LoginView.h"
#import "NSArray+Addition.h"
@interface LoginAndRegisterViewController ()
@property (nonatomic,strong) RegisterView       *registerView;
@property (nonatomic,strong) ForgetPasswordView *forgetPasswordView;
@property (nonatomic,strong) LoginView          *loginView;
@property (nonatomic,strong) UIView *currentPresentView;
@property (nonatomic,assign) CGRect             nextResponderFrame;
@end

@implementation LoginAndRegisterViewController

+(instancetype)shareInstance{
    static LoginAndRegisterViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[LoginAndRegisterViewController alloc] init];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self currentParentViewNormalConstraints];
}

#pragma mark - contraints
-(void)currentParentViewNormalConstraints{
    [self.currentPresentView makeNormalConstraints];
}

#pragma mark - UI

-(void)tapGestureTap:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
    [self.currentPresentView makeNormalConstraints];
}

-(void)hideNavigation{
    [self.view endEditing:YES];
    LoginNavigationControllerViewController *nav = (LoginNavigationControllerViewController*)self.navigationController;
    [nav hide];
}

-(void)UIConfig{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout                       = UIRectEdgeNone;///选择UIRectedgenone，视图的内容不会延伸到navigationbar的后面，就是不会顶穿导航栏
        self.extendedLayoutIncludesOpaqueBars             = NO;///这个属性指定了当bar使用了不透明图片时，视图是否延伸到bar所在区域，默认为NO
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.54];
    NSArray *left = [NSArray navigationItemsReturnWithTarget:self  selecter:@selector(hideNavigation)];
    self.navigationItem.leftBarButtonItems = left;
    [self gestureConfig];
//    [self registerViewConfig];
}

-(void)gestureConfig{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTap:)];
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark - property

-(RegisterView*)registerView{
    if(!_registerView){
        _registerView                      = [RegisterView instanceRegisterView];
        _registerView.presentViewDelegate = self;
    }
    return _registerView;
}

-(ForgetPasswordView*)forgetPasswordView{
    if(!_forgetPasswordView){
        _forgetPasswordView = [ForgetPasswordView instanceForgetPasswordView];
        _forgetPasswordView.presentViewDelegate = self;
    }
    return _forgetPasswordView;
}

-(LoginView*)loginView{
    if(!_loginView){
        _loginView = [LoginView instanceLoginView];
        _loginView.presentViewDelegate = self;
        [_loginView.forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginView;
}

-(void)forgetPasswordButtonClicked:(UIButton*)button{
    self.currentPresentViewType = CustomPresentViewType_forgetPassword;
}

-(void)registerButtonClicked:(UIButton*)button{
    self.currentPresentViewType = CustomPresentViewType_register;
}


-(void)setCurrentPresentViewType:(CustomPresentViewType)currentPresentViewType{
   
    _currentPresentViewType = currentPresentViewType;
    
    UIView *temp = [self getCurrentSpecifieViewWithType:_currentPresentViewType];
    if(!self.currentPresentView){
        [self.view addSubview:temp];
        self.currentPresentView = temp;
        [temp makeNormalConstraints];
    }
    else{
        if(self.currentPresentView != temp){
            if(self.currentPresentView.superview){
                [self transitionToNewView:temp];
            }
            
        }
    }
}

-(void)setDefaultViewType{
    self.currentPresentViewType = CustomPresentViewType_login;
}

-(void)removeCurrentPresentView{
    [self setDefaultViewType];
}

-(void)transitionToNewView:(UIView*)newView{
    
    if(_currentPresentViewType == CustomPresentViewType_login){
        [self.currentPresentView removeFromSuperview];
        self.currentPresentView = newView;
        newView.alpha = 1.0f;
        [self.view addSubview:newView];
        [newView makeNormalConstraints];
    }
    else{
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.currentPresentView.alpha = 0;
                         }completion:^(BOOL finish){
                             [self.currentPresentView removeFromSuperview];
                             self.currentPresentView = newView;
                             newView.alpha = 0.0f;
                             [self.view addSubview:newView];
                             [newView makeNormalConstraints];
                             [UIView animateWithDuration:0.5
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  newView.alpha = 1.0f;
                                              }completion:^(BOOL finish){
                                                   newView.alpha = 1.0f;
                                              }];
                         }];
    }
    
    
    
}

-(UIView*)getCurrentSpecifieViewWithType:(CustomPresentViewType)type{
    UIView *view = nil;
    switch (type) {
        case CustomPresentViewType_login:
        {
            view = (UIView*)self.loginView;
        }
            break;
        case CustomPresentViewType_register:
        {
            view = (UIView*)self.registerView;
        }
            break;
        case CustomPresentViewType_forgetPassword:
        {
            view = (UIView*)self.forgetPasswordView;
        }
            break;
        default:
            break;
    }
    return view;
}

#pragma mark - registerViewDelegate
-(void)resignConstraintWithNextResponderFrame:(CGRect)frame{
    self.nextResponderFrame = frame;
}

-(void)operationCompetition{
    [self hideNavigation];
    if(self.delegate && [self.delegate respondsToSelector:@selector(userPropertySave)]){
        [self.delegate userPropertySave];
    }
}

#pragma mark - 键盘高度
//键盘出现时受到notification，在参数userinfo中有键盘高度，坐标转为当前view
-(void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    if(keyboardRect.size.height>0){
        CGFloat registerViewOringY = keyboardRect.origin.y-10-CGRectGetMaxY(self.nextResponderFrame);
        [self.currentPresentView makeSpecificConstraintsWithTop:registerViewOringY];
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        [self.view layoutIfNeeded];
    }
    

}
@end
