//
//  DiscoverViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverTableViewDataSource.h"
#import "UIColor+Addition.h"
#import "ConversationListViewController.h"
#import "AppDelegate.h"
#import "NSArray+Addition.h"
@interface DiscoverViewController ()<DiscoverTableViewDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  数据源
 */
@property (strong,nonatomic) DiscoverTableViewDataSource *dataSource;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configDataSoucre];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configUI
-(void)configUI{
    self.tableView.backgroundColor = DiscoverTableViewBackgroundColor;
    self.title = Global_DiscoverNavigationTitleName;
    [self navigationItemConfig];
}

-(void)navigationItemConfig{
    self.navigationItem.rightBarButtonItems = [NSArray navigationItemsWithImageName:@"navigation_searchItem" target:self selecter:@selector(searchItemClick)];
}

#pragma mark - 点击事件
-(void)searchItemClick{
    
}

#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[DiscoverTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}

#pragma mark - DiscoverTableViewDataSourceDelegate
-(void)didSelectRowOfDiscoverDataType:(DiscoverTableDataType)type{
    switch (type) {
        case DiscoverTableDataType_service:
        {
            //客服
            ConversationListViewController *vc = [[ConversationListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [[AppDelegate getRootController] hideTabbar];
        }
            break;
            
        default:
            break;
    }
    
}

@end
