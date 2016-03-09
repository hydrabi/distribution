//
//  PullRefreshHeader.h
//  pullRefreshSample
//
//  Created by 毕志锋 on 15/11/12.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshHeaderDelegate.h"

@interface PullRefreshHeader : UIView

@property (nonatomic,weak) id<PullRefreshHeaderDelegate> delegate;

-(instancetype)initWithParentView:(UITableView*)parentView yPosition:(CGFloat)yPosition;

/**
 *  加载其上的父tableView滑动时调用的委托方法
 *
 *  @param parentView 需要使用header的tableView
 */
-(void)parentViewDidScroll:(UIScrollView*)parentView;

/**
 *  加载其上的父tableView放开手指时调用的委托方法
 *
 *  @param scrollView 需要使用header的tableView
 *  @param decelerate 是否正在减速
 */
-(void)parentViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

/**
 *  委托类已完成数据请求，通知其停止UI刷新动作
 */
-(void)parentViewStopLodingWithParentView:(UIScrollView*)parentView;

@end
