//
//  PersonalSettingTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingFunctionMacro.h"

@interface PersonalSettingTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *cacheLabel;
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
-(void)resetValueWithType:(PersonalSettingType)type;
@end
