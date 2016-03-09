//
//  FavoriteDataSource.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "FavoriteDataSource.h"
#import "UIScrollView+EmptyDataSet.h"


@interface FavoriteDataSource()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation FavoriteDataSource


#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"favoriteDataEmpty"];
}

#pragma mark - DZNEmptyDataSetDelegate
//数据源为空时可以滑动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

@end
