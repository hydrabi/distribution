//
//  PersonalNicknameAndSignatureFunction.h
//  Distribution
//
//  Created by Hydra on 16/1/29.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalNicknameAndSignatureMacro.h"
#import "PersonalViewControllerDelegate.h"
@interface PersonalNicknameAndSignatureFunction : UIViewController

@property (nonatomic,weak)id<PersonalViewControllerDelegate> delegate;
-(instancetype)initWithType:(PersonalInputAttributeType)type;

@end
