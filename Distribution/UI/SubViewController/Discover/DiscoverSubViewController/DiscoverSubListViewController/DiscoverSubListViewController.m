//
//  DiscoverSubListViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubListViewController.h"
#import "DiscoverSubViewListTableViewCell.h"
#import "NSArray+Addition.h"
#import "UIColor+Addition.h"
#import "DiscoverSubDetailViewController.h"
static NSString *tableViewNormalCellIndentifier = @"tableViewNormalCellIndentifier";

@interface DiscoverSubListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,assign)DiscoverTableDataType type;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@end

@implementation DiscoverSubListViewController

-(instancetype)initWithType:(DiscoverTableDataType)type{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if(self){
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self registerCellNib];
    [self configDataTypeArr];
    [self navigitionConfig];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIConfig{
    if(self.type == DiscoverTableDataType_newActivity){
        self.title = @"活动";
    }
    else if (self.type == DiscoverTableDataType_notification){
        self.title = @"通知";
    }
    self.tableView.backgroundColor     = Global_TableViewBackgroundColor;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    self.dataTypeArr = [[NSMutableArray alloc] init];
    [self configDataTypeArr];
    [self registerCellNib];
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
}
#pragma mark - 点击事件
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    self.dataTypeArr = @[@(1),
                         @(2)].mutableCopy;
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewNormalCellNib = [UINib nibWithNibName:NSStringFromClass([DiscoverSubViewListTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNormalCellNib forCellReuseIdentifier:tableViewNormalCellIndentifier];
}

#pragma mark - UITableViewDelegateAndDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataTypeArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DiscoverSubViewListTableViewCellHeight;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DiscoverSubViewListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableViewNormalCellIndentifier forIndexPath:indexPath];
    [cell resetValueWithObject:nil];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscoverSubDetailViewController *vc = [[DiscoverSubDetailViewController alloc] initWithObject:nil type:self.type];
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
