//
//  PersonalTraceFunction.m
//  Distribution
//
//  Created by Hydra on 16/3/7.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalTraceFunction.h"
#import "MJRefresh.h"
#import "RequestData.h"
#import "NSArray+Addition.h"
#import "AppDelegate.h"
@interface PersonalTraceFunction ()

@end

@implementation PersonalTraceFunction

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadTableViewData];
}

#pragma mark - 点击事件
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
    
}

#pragma mark - configUI
-(void)configUI{
    [super configUI];
    self.title = Global_TraceNavigationTitleName;
}

-(void)navigationItemConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
}

#pragma mark - 配置数据源
//-(void)configDataSoucre{
//    self.dataSource = [[FavoriteDataSource alloc] initWithTableView:self.tableView];
//    self.dataSource.delegate = self;
//}

#pragma mark - 登录状态变化
-(void)loginStatusChange{
    [self.dataSource reloadTableViewData];
}

#pragma mark - 配置数据源列表
-(void)reloadTableViewData{
    if(self.dataSource.dataTypeArr.count == 0){
        [self.tableView.mj_header beginRefreshing];
    }
    else{
        [self.dataSource reloadTableViewData];
    }
}

//同步用户数据再查询收藏
-(void)refreshData{
    if([[PersonlInfoManager shareManager] hadLogin]){
        [[PersonlInfoManager shareManager] AVUserAttributeSynchronize:^(AVObject *object, NSError *error){
            [RequestData queryTraceObjectWithCompletiton:^(NSArray *arr,NSError *error){
                if(!error){
                    self.dataSource.dataTypeArr = arr.mutableCopy;
                    [self.dataSource reloadTableViewData];
                }
            }];
            [self.tableView.mj_header endRefreshing];
        }];
    }
    else{
        [self.dataSource.dataTypeArr removeAllObjects];
        [self.dataSource reloadTableViewData];
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark - CustomBaseProductListDataSourceDelegate

-(NSString*)titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除足迹";
}

-(UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self removeTraceObjectWithIndexPath:indexPath];
}

//移除用户数据库中的足迹
-(void)removeTraceObjectWithIndexPath:(NSIndexPath*)indexPath{
    if(self.dataSource.dataTypeArr.count>indexPath.row){
        AVObject *object = self.dataSource.dataTypeArr[indexPath.row];
        AVUser *user = [AVUser currentUser];
        [user removeTraceWithObject:object];
    }
}

@end
