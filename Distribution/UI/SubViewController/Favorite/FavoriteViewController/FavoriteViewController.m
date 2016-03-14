//
//  FavoriteViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteDataSource.h"
#import "UIColor+Addition.h"
#import "CustomControllerTitleView.h"
#import "PersonalMacro.h"
#import "CommodityDetailsViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "RequestData.h"
#import "NSArray+Addition.h"

@interface FavoriteViewController ()

@property (nonatomic,strong)FavoriteDataSource *dataSource;

@end

@implementation FavoriteViewController

@dynamic dataSource;

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationItemConfig];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
    
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

#pragma mark - configUI
-(void)configUI{
    [super configUI];
    self.title = Global_FavoriteNavigationTitleName;
}

#pragma mark - 点击事件
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
    
}
-(void)navigationItemConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
}

#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[FavoriteDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}

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
            [RequestData queryFavoriteObjectWithCompletiton:^(NSArray *arr,NSError *error){
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
    return @"取消收藏";
}

-(UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self removeFavoriteObjectWithIndexPath:indexPath];
}

//移除用户数据库中的收藏
-(void)removeFavoriteObjectWithIndexPath:(NSIndexPath*)indexPath{
    if(self.dataSource.dataTypeArr.count>indexPath.row){
        AVObject *object = self.dataSource.dataTypeArr[indexPath.row];
        AVUser *user = [AVUser currentUser];
        [user removeFavoriteWithObjectId:object];
    }
}

@end
