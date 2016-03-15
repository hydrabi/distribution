//
//  PersonalAddressListViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/12.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAddressListViewController.h"
#import "NSArray+Addition.h"
#import "AppDelegate.h"
#import "UIColor+Addition.h"
#import "PersonalAddressListFooterView.h"
#import "PersonalManagerAddressMacro.h"
#import "UIScrollView+EmptyDataSet.h"
#import "PersonalAddressListTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PersonalAddressDetailViewController.h"
#import "PersonalManageerAddressViewController.h"
#import "PersonalMacro.h"

static NSString *tableViewAddressListCellIndentifier = @"tableViewAddressListCellIndentifier";

@interface PersonalAddressListViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,strong)PersonalAddressListFooterView *footerView;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@end

@implementation PersonalAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self navigitionConfig];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(PersonalAddressListFooterView*)footerView{
    if(!_footerView){
        _footerView = [[PersonalAddressListFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), PersonalAddrestListFooterHeight)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerViewClick)];
        [_footerView addGestureRecognizer:tap];
    }
    return _footerView;
}

#pragma mark - configUI
-(void)UIConfig{
    [self registerCellNib];
    
    self.title                          = @"收货地址管理";
    self.tableView.backgroundColor      = Global_TableViewBackgroundColor;
    self.tableView.delegate             = self;
    self.tableView.dataSource           = self;
    self.tableView.emptyDataSetSource   = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self configDataTypeArr];
    [self navigitionConfig];
    [self footerViewConfig];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configDataTypeArr) name:Notification_PersonalInfoChange object:nil];
}

-(void)footerViewConfig{
    self.tableView.tableFooterView = self.footerView;
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
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

#pragma mark - 点击事件
-(void)footerViewClick{
    PersonalManageerAddressViewController *vc = [[PersonalManageerAddressViewController alloc] initWithType:PersonalManagerAddressType_new addressDic:nil addressDicIndex:0];
    [self.navigationController pushViewController:vc animated:YES];
}

//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSArray *temp = user[AVUserKey_addressList];
        self.dataTypeArr = temp.mutableCopy;
    }
    else{
        self.dataTypeArr = @[].mutableCopy;
    }
    [self.tableView reloadData];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewNormalCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalAddressListTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNormalCellNib forCellReuseIdentifier:tableViewAddressListCellIndentifier];

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
    CGFloat height = PersonalAddrestListCellHeight;
    
    if(self.dataTypeArr.count>indexPath.row){
        height =[self.tableView fd_heightForCellWithIdentifier:tableViewAddressListCellIndentifier configuration:^(PersonalAddressListTableViewCell *cell) {
            [cell resetValueWithAddressDic:self.dataTypeArr[indexPath.row]];
        }];
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 10;
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    PersonalAddressListTableViewCell *addressCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewAddressListCellIndentifier forIndexPath:indexPath];
    if(self.dataTypeArr.count>indexPath.row){
        [addressCell resetValueWithAddressDic:self.dataTypeArr[indexPath.row]];
    }
    cell = (UITableViewCell*)addressCell;    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataTypeArr.count>indexPath.row){
        NSDictionary *addressDic = self.dataTypeArr[indexPath.row];
        PersonalAddressDetailViewController *vc = [[PersonalAddressDetailViewController alloc] initWithAddrestDic:addressDic addressDicIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        [[AppDelegate getRootController] hideTabbar];
    }
   
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableViewCell分割线左边距为12
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除地址";
}

//删除收藏
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [self removeObjectWithIndexPath:indexPath];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
        
        if(self.dataTypeArr.count == 0){
            [tableView reloadData];
        }
    }
}

-(void)removeObjectWithIndexPath:(NSIndexPath*)indexPath{
    if(self.dataTypeArr.count>indexPath.row){
        NSDictionary *addressDic = self.dataTypeArr[indexPath.row];
        AVUser *user = [AVUser currentUser];
        if(user){
            [user removeAddressWithDic:addressDic];
        }
        [self.dataTypeArr removeObjectAtIndex:indexPath.row];
    }
    
}

#pragma mark - DZNEmptyDataSetDelegate
//数据源为空时可以滑动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"您暂时还没有收货地址哦";
    
    NSDictionary *attributes = @{NSFontAttributeName: PersonalAddrestListFooterTitleFont,
                                 NSForegroundColorAttributeName: PersonalAddrestListFooterTitleColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
@end
