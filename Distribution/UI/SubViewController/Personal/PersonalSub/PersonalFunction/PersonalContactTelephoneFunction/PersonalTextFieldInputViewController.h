//
//  PersonalContactTelephoneViewController.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalViewControllerDelegate.h"
#import "PersonalContactTelephoneTableViewCell.h"

@interface PersonalTextFieldInputViewController : UIViewController
@property (nonatomic,weak)id<PersonalViewControllerDelegate> delegate;
-(instancetype)initWithPersonalViewTextFieldInputType:(PersonalViewTextFieldInputType)type;
@end
