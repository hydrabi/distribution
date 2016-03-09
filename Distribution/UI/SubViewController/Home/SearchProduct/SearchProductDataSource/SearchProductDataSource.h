//
//  SearchProductDataSource.h
//  Distribution
//
//  Created by Hydra on 16/3/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchProductDataSourceDelegate.h"

@interface SearchProductDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)id<SearchProductDataSourceDelegate> delegate;

/**
 *  初始化的同时传递tableView
 *
 *  @param tableView resultView里面的TableView
 *
 *  @return DataSource实例
 */
-(instancetype)initWithTableView:(UITableView*)tableView dataArr:(NSArray *)dataArr;

@end
