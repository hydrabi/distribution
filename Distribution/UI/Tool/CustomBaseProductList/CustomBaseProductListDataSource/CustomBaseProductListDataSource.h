//
//  CustomBaseProductListDataSource.h
//  Distribution
//
//  Created by Hydra on 16/3/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomBaseProductListDataSourceDelegate.h"
@interface CustomBaseProductListDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)id<CustomBaseProductListDataSourceDelegate> delegate;

/**
 *  从about中传递过来的tableView
 */
@property (nonatomic,weak) UITableView *tableView;

/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;

/**
 *  初始化的同时传递tableView
 *
 *  @param tableView resultView里面的TableView
 *
 *  @return DataSource实例
 */
- (instancetype)initWithTableView:(UITableView*)tableView;

-(void)reloadTableViewData;

@end
