//
//  ClassifyViewTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestData.h"
@interface ClassifyViewTableViewCell : UITableViewCell

@property (nonatomic,weak)IBOutlet UILabel *titleLabel;

@property (nonatomic,weak)IBOutlet UIImageView *headImage;

-(void)resetValueWithType:(productType)type;

@end
