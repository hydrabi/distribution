//
//  CDImageTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDImageTableViewCellDelegate.h"
@interface CDImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image0;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) id<CDImageTableViewCellDelegate> delegate;
-(void)configImgeWithImageArr:(NSMutableArray*)imageArr indexPath:(NSIndexPath*)indexPath;
@end
