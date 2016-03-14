//
//  PersonalManageerAddressViewController.h
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalManagerAddressMacro.h"
@interface PersonalManageerAddressViewController : UIViewController
-(instancetype)initWithType:(PersonalManagerAddressType)type addressDic:(NSDictionary*)addressDic addressDicIndex:(NSInteger)index;
@end
