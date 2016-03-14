//
//  PersonalAddressDetailTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalManagerAddressMacro.h"

@interface PersonalAddressDetailTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UILabel *valueLabel;
-(void)resetValueWithType:(PersonalAddressDetailCellType)type;
@end
