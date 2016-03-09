//
//  PersonalMainTableViewDataSource.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalMainTableViewDataSourceDelegate.h"
@interface PersonalMainTableViewDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)id <PersonalMainTableViewDataSourceDelegate> delegate;

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
