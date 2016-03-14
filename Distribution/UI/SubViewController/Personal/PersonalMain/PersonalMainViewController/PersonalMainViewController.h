//
//  PersonalMainViewController.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalMainMacro.h"
#import "PersonalMainOrderCellButton.h"
typedef void (^MainClickButtonTypeCallBack) (PersonalMainOrderCellButtonType);
@interface PersonalMainViewController : UIViewController
@property (nonatomic,copy)MainClickButtonTypeCallBack callBack;
@end
