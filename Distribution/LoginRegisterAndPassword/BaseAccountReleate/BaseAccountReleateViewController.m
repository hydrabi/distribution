//
//  BaseAccountReleateViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "BaseAccountReleateViewController.h"
#import "NSArray+Addition.h"
#import "AppDelegate.h"
#import "UIColor+Addition.h"
#import "VerifyButtonTextFieldTableViewCell.h"
#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "BaseAccountReleateTableViewHeader.h"
#import "BaseAccountReleateTableViewFooter.h"

@interface BaseAccountReleateViewController ()
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)BaseAccountReleateTableViewFooter *footerView;
@end

@implementation BaseAccountReleateViewController

-(instancetype)initWithType:(AccountReleateViewControllerType)type{
    self = [super init];
    if(self){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configDataTypeArr];
    [self UIConfig];
    [self registerCellNib];
    [self navigitionConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - configUI
-(void)UIConfig{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    __weak typeof(self)weakSelf = self;
    [self.tableView makeConstraints:^(MASConstraintMaker* make){
        make.leading.equalTo(weakSelf.view.leading);
        make.trailing.equalTo(weakSelf.view.trailing);
        make.top.equalTo(weakSelf.view.top);
        make.bottom.equalTo(weakSelf.view.bottom);
    }];
    
    self.tableView.backgroundColor      = Global_TableViewBackgroundColor;
    self.tableView.delegate             = self;
    self.tableView.dataSource           = self;
    self.tableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    
    if(self.type!=AccountReleateViewControllerType_Login){
        self.tableView.tableHeaderView = [[BaseAccountReleateTableViewHeader alloc] initWithType:self.type frame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), BaseAccountTableViewHeaderHeight)];
    }
    
    self.footerView = [[BaseAccountReleateTableViewFooter alloc] initWithType:self.type frame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), BaseAccountTableViewFooterHeight)];
    self.tableView.tableFooterView = self.footerView;
    [self.footerView.mainButton addTarget:self action:@selector(mainButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView.subButton addTarget:self action:@selector(subButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
}

#pragma mark - 点击事件

//返回
-(void)returnButtonClick{
    
}

-(void)mainButtonClick{
    
}

-(void)subButtonClick{
    
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    
    
}

-(AccountReleateCellType)getSpecificTypeWithIndexPath:(NSIndexPath*)indexPath{
    AccountReleateCellType type;
    if(self.dataTypeArr.count>indexPath.row){
        type = (AccountReleateCellType)[self.dataTypeArr[indexPath.row] integerValue];
    }
    return type;
}

-(void)clearTextField{
    
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *verifyCellNib = [UINib nibWithNibName:NSStringFromClass([VerifyButtonTextFieldTableViewCell class]) bundle:nil];
    [self.tableView registerNib:verifyCellNib forCellReuseIdentifier:verifyButtonTextFieldTableViewCellReuseIdentifier];
    
    UINib *inputCellNib = [UINib nibWithNibName:NSStringFromClass([CustomPrefixInputTextFieldTableViewCell class]) bundle:nil];
    [self.tableView registerNib:inputCellNib forCellReuseIdentifier:customPrefixInputTextFieldTableViewCellReuseIdentifier];
    
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
    CGFloat height = BaseAccountTableViewCellHeight;
    return height;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    if(self.type != AccountReleateViewControllerType_Login){
        height = 0.1;
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.1;
    
    return height;
}
@end
