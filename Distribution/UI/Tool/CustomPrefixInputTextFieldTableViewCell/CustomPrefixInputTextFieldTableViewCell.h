//
//  CustomPrefixInputTextFieldTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//  带有前缀的textField输入cell

#import <UIKit/UIKit.h>

@interface CustomPrefixInputTextFieldTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UITextField *textField;
@end
