//
//  CDIntroduceTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDIntroduceTableViewCellDelegate.h"
@interface CDIntroduceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIButton *introduceCopyButton;
@property (weak, nonatomic) IBOutlet UILabel *introduceTitleLabel;
@property (weak,nonatomic) id<CDIntroduceTableViewCellDelegate> delegate;
-(void)resetValueWithObject:(AVObject*)object;
@end
