//
//  PersonalMainTableViewHeader.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalMainTableViewHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+(instancetype)instancePersonalMainTableViewHeader;

@end
