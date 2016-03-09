//
//  PersonalNormalCell.h
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITabelViewSeparatorView.h"
#import "PersonalTableViewDataSourceDelegate.h"

@interface PersonalNormalCell : UITabelViewSeparatorView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(void)detailConfigWithType:(PersonalTableDataType)type;

@end
