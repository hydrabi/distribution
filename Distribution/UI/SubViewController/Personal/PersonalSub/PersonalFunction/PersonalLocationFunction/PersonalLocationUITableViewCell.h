//
//  PersonalLocationUITableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalLocationUITableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
-(void)detailConfig;
-(void)fillDetailWithLocation:(NSString*)location;
@end
