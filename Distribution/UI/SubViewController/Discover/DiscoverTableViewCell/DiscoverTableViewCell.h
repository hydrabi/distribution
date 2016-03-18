//
//  DiscoverTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverlMacro.h"

@interface DiscoverTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImage;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (assign,nonatomic) DiscoverTableDataType dataType;
@end
