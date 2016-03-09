//
//  PersonalGenderViewController.h
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalViewControllerDelegate.h"
@interface PersonalGenderViewController : UIViewController
@property (nonatomic,weak)id<PersonalViewControllerDelegate> delegate;
@end
