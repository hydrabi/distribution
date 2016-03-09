//
//  CustomBaseProductListViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomBaseProductListViewController.h"
#import "CustomBaseProductListMacro.h"
#import "CommodityDetailsViewController.h"
#import "AppDelegate.h"
#import "UIColor+Addition.h"
@interface CustomBaseProductListViewController ()
@end

@implementation CustomBaseProductListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configDataSoucre];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

//tableViewCell分割线左边距为0
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,ProductListTableViewCellLeftSeparatorInset,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,ProductListTableViewCellLeftSeparatorInset,0,0)];
    }
}

#pragma mark - configUI
-(void)configUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf = self;
    [self.tableView makeConstraints:^(MASConstraintMaker*make){
        make.leading.equalTo(weakSelf.view.leading);
        make.trailing.equalTo(weakSelf.view.trailing);
        make.top.equalTo(weakSelf.view.top);
        make.bottom.equalTo(weakSelf.view.bottom);
    }];
    self.tableView.backgroundColor = ProductListTableViewBackgroundColor;
}

#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[CustomBaseProductListDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}


#pragma mark - delegate
-(void)didSelectRowWithObject:(AVObject *)object{
    CommodityDetailsViewController *vc = [[CommodityDetailsViewController alloc] initWithObject:object];
    [self.navigationController pushViewController:vc animated:YES];
    [[AppDelegate getRootController]hideTabbar];
}

@end
