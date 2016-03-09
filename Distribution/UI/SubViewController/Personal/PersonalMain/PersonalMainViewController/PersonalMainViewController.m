//
//  PersonalMainViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainViewController.h"
#import "PersonalMainTableViewDataSource.h"
#import "PersonalMacro.h"
#import "PersonalMainMacro.h"
#import "UIColor+Addition.h"
#import "PersonalViewController.h"
#import "AppDelegate.h"
#import "LoginNavigationControllerViewController.h"
#import "PersonalTraceFunction.h"
#import "PersonalSettingFunctionViewController.h"

@interface PersonalMainViewController ()<PersonalMainTableViewDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  数据源
 */
@property (strong,nonatomic) PersonalMainTableViewDataSource *dataSource;

@end

@implementation PersonalMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configDataSoucre];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataSource reloadTableViewData];
}

#pragma mark - action
/**登录状态改变*/
-(void)loginStatusChange{
    [self.dataSource reloadTableViewData];
}

#pragma mark - configUI
-(void)configUI{
    self.title = Global_PersonalMainNavigationTitleName;
    self.tableView.backgroundColor = PersonalMainTableViewBackgroundColor;
}

#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[PersonalMainTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}

#pragma mark - PersonalMainTableViewDataSourceDelegate
-(void)didSelectRowOfPersonalMainDataType:(PersonalMainTableDataType)type{
    if(![[PersonlInfoManager shareManager] hadLogin]){
        //未登录，弹出登录框
        [[LoginNavigationControllerViewController shareInstance] showWithRootViewController];
        return;
    }
    
    switch (type) {
        case PersonalMainTableDataType_name:
        {
            PersonalViewController *personalVc = [[PersonalViewController alloc] init];
            [self.navigationController pushViewController:personalVc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalMainTableDataType_footprint:
        {
            PersonalTraceFunction *trace = [[PersonalTraceFunction alloc] init];
            [self.navigationController pushViewController:trace animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalMainTableDataType_setting:
        {
            PersonalSettingFunctionViewController *setting = [[PersonalSettingFunctionViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        default:
            break;
    }
}

@end
