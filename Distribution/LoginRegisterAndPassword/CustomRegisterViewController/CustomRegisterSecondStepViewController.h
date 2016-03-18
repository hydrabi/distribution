//
//  CustomRegisterSecondStepViewController.h
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAccountReleateViewController.h"
@interface CustomRegisterSecondStepViewController : BaseAccountReleateViewController
@property (nonatomic,strong)NSString *telephone;
@property (nonatomic,strong)NSString *verifyCode;
+(instancetype)shareInstance;
@end
