//
//  PersonalNicknameAndSignatureTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/29.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalNicknameAndSignatureMacro.h"
@interface PersonalNicknameAndSignatureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textFileld;
@property (assign,nonatomic)PersonalInputAttributeType type;
@end
