//
//  CDMainTableViewCellDelegate.h
//  Distribution
//
//  Created by Hydra on 16/3/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDMainTableViewCell;
@protocol CDMainTableViewCellDelegate <NSObject>

@optional

-(void)clickImageCell:(CDMainTableViewCell*)imageCell;
-(void)weixinShareButtonClick;

@end