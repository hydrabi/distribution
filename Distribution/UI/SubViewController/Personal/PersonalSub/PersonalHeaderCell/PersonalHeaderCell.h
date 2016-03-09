//
//  PersonalHeaderCell.h
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITabelViewSeparatorView.h"

@interface PersonalHeaderCell : UITabelViewSeparatorView
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

-(void)detailConfig;
@end
