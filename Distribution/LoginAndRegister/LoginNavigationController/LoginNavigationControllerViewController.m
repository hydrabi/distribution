//
//  LoginNavigationControllerViewController.m
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "LoginNavigationControllerViewController.h"
#import "LoginAndRegisterViewController.h"
#import "AppDelegate.h"
#import "UIColor+Addition.h"
#define animationDuration 0.3f
@interface LoginNavigationControllerViewController ()

@end

@implementation LoginNavigationControllerViewController

+(instancetype)shareInstance{
    static LoginNavigationControllerViewController *nav = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LoginAndRegisterViewController *vc = [LoginAndRegisterViewController shareInstance];
        nav = [[LoginNavigationControllerViewController alloc] init];
        [nav pushViewController:vc animated:NO];
    });
    return nav;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#000000" alpha:1];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showWithRootViewController{
    RootViewController *root = [AppDelegate getRootController];
    [[LoginNavigationControllerViewController shareInstance] showWithParent:root.view];
}

-(void)showWithParent:(UIView *)parentView{
    LoginAndRegisterViewController *vc = [LoginAndRegisterViewController shareInstance];
    [vc setDefaultViewType];
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    UIView *attechView = parentView;
    if(!attechView){
        attechView = [[UIApplication sharedApplication].windows lastObject];
    }
    self.view.frame = CGRectMake(0,
                                 CGRectGetHeight(screenRect),
                                 CGRectGetWidth(screenRect),
                                 CGRectGetHeight(screenRect));
    [parentView addSubview:self.view];
    [UIView animateWithDuration:animationDuration
                          delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.frame = CGRectMake(0,
                                                      0,
                                                      CGRectGetWidth(screenRect),
                                                      CGRectGetHeight(screenRect));
                     }
                     completion:^(BOOL finish){
                         LoginAndRegisterViewController *vc = [LoginAndRegisterViewController shareInstance];
                         [vc currentParentViewNormalConstraints];
                     }];
}

-(void)hide{
    if(self.view.superview){
        [UIView animateWithDuration:animationDuration
                              delay:0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.frame = CGRectMake(0,
                                                          CGRectGetHeight(self.view.bounds),
                                                          CGRectGetWidth(self.view.bounds),
                                                          CGRectGetHeight(self.view.bounds));
                         }
                         completion:^(BOOL finish){
                             LoginAndRegisterViewController *vc = [LoginAndRegisterViewController shareInstance];
                             [vc removeCurrentPresentView];
                             [self.navigationController.view removeFromSuperview];
                         }];
    }
}

@end
