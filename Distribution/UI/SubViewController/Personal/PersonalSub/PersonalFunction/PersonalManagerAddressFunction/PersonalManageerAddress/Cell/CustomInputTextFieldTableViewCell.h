//
//  CustomInputTextFieldTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalManagerAddressMacro.h"
@interface CustomInputTextFieldTableViewCell : UITableViewCell
@property (nonatomic,assign)CustomInputTextFieldCellType type;
@property (nonatomic,weak)IBOutlet UITextField *textField;
@end
