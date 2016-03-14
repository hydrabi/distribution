//
//  PersonalMainNameTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalMainNameTableViewCellDelegate.h"
@interface PersonalMainNameTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
/**
 *  工具栏背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *toolBarBackgroundView;

@property (weak,nonatomic)id <PersonalMainNameTableViewCellDelegate> delegate;

/**
 *  重新加载用户资料
 */
-(void)reloadUserData;

@end
