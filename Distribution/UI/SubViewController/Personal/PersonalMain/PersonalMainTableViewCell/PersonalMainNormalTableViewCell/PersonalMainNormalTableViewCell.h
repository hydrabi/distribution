//
//  PersonalMainNormalTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalMainTableViewDataSourceDelegate.h"

@interface PersonalMainNormalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (assign,nonatomic) PersonalMainTableDataType dataType;
@end
