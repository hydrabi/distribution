//
//  PersonalMainNameTableViewCellDelegate.h
//  Distribution
//
//  Created by Hydra on 16/3/11.
//  Copyright © 2016年 distribution. All rights reserved.
//
#import "PersonalMainMacro.h"
@protocol PersonalMainNameTableViewCellDelegate <NSObject>

-(void)mainButtonClickWithType:(PersonalMainOrderCellButtonType)type;

@end