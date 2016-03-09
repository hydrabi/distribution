//
//  CommodityDetailsDataSource.h
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommodityDetailsDataSourceDelegate.h"
@interface CommodityDetailsDataSource : NSObject

@property (nonatomic,weak)id<CommodityDetailsDataSourceDelegate> delegate;

/**
 *  初始化的同时传递tableView
 *
 *  @param tableView resultView里面的TableView
 *
 *  @return DataSource实例
 */
-(instancetype)initWithTableView:(UITableView*)tableView object:(AVObject*)object;

-(void)reloadTableViewData;

/**
 *  刷新数据后重新配置页面数据源
 *
 *  @param data 查询成功后获得的数据
 */
-(void)resetDataSource:(NSMutableDictionary*)data;

@end
