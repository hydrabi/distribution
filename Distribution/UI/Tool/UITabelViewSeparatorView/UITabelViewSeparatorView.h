//
//  UITabelViewSeparatorView.h
//  YQTrack
//
//  Created by 毕志锋 on 15/9/15.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  在tableView中分隔开section的填充view，有上下分割线，能隐藏任意一条
 */
@interface UITabelViewSeparatorView : UITableViewCell

/**
 *  展示上面的分割线
 */
-(void)showAboveLine;

/**
 *  展示下面的分割线
 */
-(void)showFloorLine;

/**
 *  展示上下两条分割线
 */
-(void)showBothLine;

/**
 *  隐藏上下两条分割线
 */
-(void)hideBothLine;
@end
