//
//  PersonalMainOrderCellButton.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalMainMacro.h"

@interface PersonalMainOrderCellButton : UIButton

-(instancetype)initWithButtonType:(PersonalMainOrderCellButtonType)type;
-(instancetype)initWithButtonType:(PersonalMainOrderCellButtonType)type font:(UIFont*)font titleColor:(UIColor*)color;
@end
