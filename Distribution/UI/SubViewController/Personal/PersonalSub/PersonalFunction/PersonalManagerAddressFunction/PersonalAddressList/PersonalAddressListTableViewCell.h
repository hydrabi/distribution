//
//  PersonalAddressListTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalAddressListTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *nameLabel;
@property (nonatomic,weak)IBOutlet UILabel *telephoneLabel;
@property (nonatomic,weak)IBOutlet UILabel *adressLabel;

-(void)resetValueWith;
@end
