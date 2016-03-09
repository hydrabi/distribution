//
//  PersonalTableViewDataSource.h
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalTableViewDataSourceDelegate.h"
@interface PersonalTableViewDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)id <PersonalTableViewDataSourceDelegate> delegate;

/**
 *  初始化的同时传递tableView
 *
 *  @param tableView resultView里面的TableView
 *
 *  @return DataSource实例
 */
- (instancetype)initWithTableView:(UITableView*)tableView;

-(void)reloadTableViewData;

-(void)resetTableViewFooter;

/**
 *  根据当前状态退出或者登录
 */
-(void)footerButtonClick;
@end
