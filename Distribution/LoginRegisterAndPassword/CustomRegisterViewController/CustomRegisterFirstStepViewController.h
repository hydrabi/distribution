//
//  CustomRegisterFirstStepViewController.h
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAccountReleateViewController.h"
@interface CustomRegisterFirstStepViewController : BaseAccountReleateViewController
+(instancetype)shareInstance;
-(NSString*)getTelephoneString;
-(NSString*)getVerifyCode;
@end
