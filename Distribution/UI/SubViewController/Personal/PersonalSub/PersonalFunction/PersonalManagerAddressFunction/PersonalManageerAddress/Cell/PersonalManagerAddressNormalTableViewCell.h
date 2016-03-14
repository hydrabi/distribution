//
//  PersonalManagerAddressNormalTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalManagerAddressNormalTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
-(void)resetValueWith:(NSString*)str;
@end
