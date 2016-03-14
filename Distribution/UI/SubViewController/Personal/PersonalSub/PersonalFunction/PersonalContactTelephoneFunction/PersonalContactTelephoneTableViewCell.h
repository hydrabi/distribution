//
//  PersonalContactTelephoneTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PersonalViewTextFieldInputType) {
    PersonalViewTextFieldInputType_telephone,
    PersonalViewTextFieldInputType_weixin,
    PersonalViewTextFieldInputType_qq
};
@interface PersonalContactTelephoneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;

-(void)resetValueWithType:(PersonalViewTextFieldInputType)type;
@end
