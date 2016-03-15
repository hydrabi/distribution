//
//  BaseAccountReleateTableViewFooter.h
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginRegisterAndPasswordMacro.h"
@interface BaseAccountReleateTableViewFooter : UIView
@property (nonatomic,strong)UIButton *mainButton;
@property (nonatomic,strong)UIButton *subButton;
-(instancetype)initWithType:(AccountReleateViewControllerType)type frame:(CGRect)frame;
@end
