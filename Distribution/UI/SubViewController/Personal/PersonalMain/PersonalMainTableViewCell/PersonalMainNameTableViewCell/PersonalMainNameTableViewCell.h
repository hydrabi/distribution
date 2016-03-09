//
//  PersonalMainNameTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalMainNameTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
/**
 *  签名
 */
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
/**
 *  箭头
 */
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

/**
 *  重新加载用户资料
 */
-(void)reloadUserData;

@end
