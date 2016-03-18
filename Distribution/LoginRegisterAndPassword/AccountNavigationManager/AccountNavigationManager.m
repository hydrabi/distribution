//
//  AccountNavigationManager.m
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "AccountNavigationManager.h"
#import "CustomForgetPasswordViewController.h"
#import "CustomLoginViewController.h"
#import "CustomRegisterFirstStepViewController.h"
#import "CustomRegisterSecondStepViewController.h"
#import "NavigationController.h"
#import "AppDelegate.h"

@interface AccountNavigationManager()
@property (nonatomic,strong)NavigationController *loginNav;
@property (nonatomic,strong)NavigationController *forgetPasswordNav;
@property (nonatomic,strong)NavigationController *registerNav;
@property (nonatomic,strong)CustomLoginViewController *loginViewController;
@property (nonatomic,strong)CustomForgetPasswordViewController *forgetPasswordViewController;
@property (nonatomic,strong)CustomRegisterFirstStepViewController *registerFirstStepViewController;
@property (nonatomic,strong)CustomRegisterSecondStepViewController *registerSecondStepViewController;
/**
 *  是否已经弹出了nav
 */
@property (nonatomic,assign,getter=isPresenting)BOOL presenting;
/**
 *  正在弹出的nav类型
 */
@property (nonatomic,assign)AccountReleateViewControllerType presentingNavType;
@end

@implementation AccountNavigationManager

+(instancetype)shareInstance{
    static AccountNavigationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AccountNavigationManager alloc] init];
    });
    return manager;
}

-(CustomLoginViewController*)loginViewController{
    if(!_loginViewController){
        _loginViewController = [CustomLoginViewController shareInstance];
    }
    return _loginViewController;
}

-(CustomForgetPasswordViewController*)forgetPasswordViewController{
    if(!_forgetPasswordViewController){
        _forgetPasswordViewController = [CustomForgetPasswordViewController shareInstance];
    }
    return _forgetPasswordViewController;
}

-(CustomRegisterFirstStepViewController*)registerFirstStepViewController{
    if(!_registerFirstStepViewController){
        _registerFirstStepViewController = [CustomRegisterFirstStepViewController shareInstance];
    }
    return _registerFirstStepViewController;
}

-(CustomRegisterSecondStepViewController*)registerSecondStepViewController{
    if(!_registerSecondStepViewController){
        _registerSecondStepViewController = [CustomRegisterSecondStepViewController shareInstance];
    }
    return _registerSecondStepViewController;
}

-(NavigationController*)loginNav{
    if(!_loginNav){
        _loginNav = [[NavigationController alloc] initWithRootViewController:self.loginViewController];
    }
    return _loginNav;
}

-(NavigationController*)forgetPasswordNav{
    if(!_forgetPasswordNav){
        _forgetPasswordNav = [[NavigationController alloc] initWithRootViewController:self.forgetPasswordViewController];
    }
    return _forgetPasswordNav;
}

-(NavigationController*)registerNav{
    if(!_registerNav){
        _registerNav = [[NavigationController alloc] initWithRootViewController:self.registerFirstStepViewController];
    }
    return _registerNav;
}

-(void)showNavWithType:(AccountReleateViewControllerType)type{
    switch (type) {
        case AccountReleateViewControllerType_Login:
        {
            if(self.isPresenting){
                [self hideNavWithCompletion:^{
                    [[AppDelegate getRootController] presentViewController:self.loginNav animated:YES completion:^{
                        
                    }];
                }];
            }
            else{
                [[AppDelegate getRootController] presentViewController:self.loginNav animated:YES completion:^{
                    
                }];
            }
            self.presentingNavType = type;
        }
            break;
        case AccountReleateViewControllerType_forgetPassword:
        {
            if(self.isPresenting){
                [self hideNavWithCompletion:^{
                    [[AppDelegate getRootController] presentViewController:self.forgetPasswordNav animated:YES completion:^{
                        
                    }];
                }];
            }
            else{
                [[AppDelegate getRootController] presentViewController:self.forgetPasswordNav animated:YES completion:^{
                    
                }];
            }
            self.presentingNavType = type;
        }
            break;
        case AccountReleateViewControllerType_RegisterFirst:
        {
            if(self.isPresenting){
                [self hideNavWithCompletion:^{
                    [[AppDelegate getRootController] presentViewController:self.registerNav animated:YES completion:^{
                        
                    }];
                }];
            }
            else{
                [[AppDelegate getRootController] presentViewController:self.registerNav animated:YES completion:^{
                    
                }];
            }
            self.presentingNavType = type;
        }
            break;
        case AccountReleateViewControllerType_RegisterSecond:
        {
            if(self.isPresenting){
                self.registerSecondStepViewController.telephone = [self.registerFirstStepViewController getTelephoneString];
                self.registerSecondStepViewController.verifyCode = [self.registerFirstStepViewController getVerifyCode];
                [self.registerNav pushViewController:self.registerSecondStepViewController animated:YES];
            }
            
        }
            break;
        default:
            break;
    }
    
    self.presenting = YES;
    
}

-(void)hideNavWithCompletion:(void (^)(void))completion{
    if(self.isPresenting){
        switch (self.presentingNavType) {
            case AccountReleateViewControllerType_Login:
            {
                [self.loginNav dismissViewControllerAnimated:YES completion:^{
                    completion();
                }];
            }
                break;
            case AccountReleateViewControllerType_forgetPassword:
            {
                [self.forgetPasswordNav dismissViewControllerAnimated:YES completion:^{
                    completion();
                }];
            }
                break;
            case AccountReleateViewControllerType_RegisterFirst:
            {
                [self.registerNav dismissViewControllerAnimated:YES completion:^{
                    completion();
                }];
            }
                break;
            default:
                break;
        }
    }
    self.presenting = NO;
}

-(void)clearRegisterTextField{
    [self.registerFirstStepViewController clearTextField];
    [self.registerSecondStepViewController clearTextField];
}
@end
