//
//  PersonalGenderTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PersonalGenderCellType) {
    PersonalGenderCellType_male,
    PersonalGenderCellType_female
};

@interface PersonalGenderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
