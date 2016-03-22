//
//  ShoppingCarViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "UIColor+Addition.h"
#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarMacro.h"
#import "UIScrollView+EmptyDataSet.h"

static NSString *shoppingCarTableViewCellIndentifier = @"shoppingCarTableViewCellIndentifier";

@interface ShoppingCarViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,weak)IBOutlet UITableView *tableView;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self registerCellNib];
    [self configDataTypeArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIConfig{
    
    self.title                          = @"购物车";

    self.tableView.backgroundColor      = Global_TableViewBackgroundColor;
    self.tableView.delegate             = self;
    self.tableView.dataSource           = self;
    self.tableView.emptyDataSetSource   = self;
    self.tableView.emptyDataSetDelegate = self;

    self.dataTypeArr                    = [[NSMutableArray alloc] init];
    [self configDataTypeArr];
    [self registerCellNib];
}

//tableViewCell分割线左边距为0
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    self.dataTypeArr = @[@(1)].mutableCopy;
}

#pragma mark - 注册tableView要用到的所有CellNib

-(void)registerCellNib{
    UINib *shoppingCarTableViewCellNib = [UINib nibWithNibName:NSStringFromClass([ShoppingCarTableViewCell class]) bundle:nil];
    [self.tableView registerNib:shoppingCarTableViewCellNib forCellReuseIdentifier:shoppingCarTableViewCellIndentifier];
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
    return shoppingCarTableViewCellHeight;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.1;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.1;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingCarTableViewCellIndentifier forIndexPath:indexPath];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - DZNEmptyDataSetSource 当页面为空时出现的提示
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"哎呀！购物车是空的";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithHexString:@"6f6f6f" alpha:1]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"去逛逛吧~";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithHexString:@"c0c0c0" alpha:1]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"shoppingCar_dataEmpty"];
}

@end
