//
//  AccountNavigationManager.h
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginRegisterAndPasswordMacro.h"
@interface AccountNavigationManager : NSObject
+(instancetype)shareInstance;
-(void)showNavWithType:(AccountReleateViewControllerType)type;
-(void)hideNavWithCompletion:(void (^)(void))completion;
@end
