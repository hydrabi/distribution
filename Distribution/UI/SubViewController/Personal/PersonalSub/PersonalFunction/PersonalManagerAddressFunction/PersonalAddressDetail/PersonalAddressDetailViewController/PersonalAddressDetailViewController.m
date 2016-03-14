//
//  PersonalAddressDetailViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/13.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAddressDetailViewController.h"
#import "NSArray+Addition.h"
#import "AppDelegate.h"
#import "UIColor+Addition.h"
#import "PersonalManagerAddressMacro.h"
#import "PersonalAddressDetailTableViewCell.h"
#import "PersonalManageerAddressViewController.h"

static NSString *tableViewDetailTableViewCellReuseIdentifier = @"tableViewDetailTableViewCellReuseIdentifier";

@interface PersonalAddressDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
/**
 *  默认收货地址按钮
 */
@property (nonatomic,strong)UIButton *defaultAddressButton;
/**
 *  收货地址信息
 */
@property (nonatomic,strong)NSDictionary *addressDic;
/**
 *  收货地址相对于收货地址列表的索引
 */
@property (nonatomic,assign)NSInteger addressDicIndex;
@end

@implementation PersonalAddressDetailViewController

-(instancetype)initWithAddrestDic:(NSDictionary*)addressDic addressDicIndex:(NSInteger)index{
    self = [super init];
    if(self){
        self.addressDic      = addressDic;
        self.addressDicIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configDataTypeArr];
    [self UIConfig];
    [self registerCellNib];
    [self navigitionConfig];
    // Do any additional setup after loading the view from its nib.
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
    self.title                          = @"收货地址";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.defaultAddressButton = [[UIButton alloc] init];
    [self.defaultAddressButton setTitle:PersonalAddressDetailDefaultButtonTitle forState:UIControlStateNormal];
    [self.defaultAddressButton setBackgroundColor:PersonalAddressDetailDefaultButtonBackgroundColor];
    [self.defaultAddressButton setTitleColor:PersonalAddressDetailDefaultButtonTitleColor forState:UIControlStateNormal];
    [self.defaultAddressButton addTarget:self action:@selector(defaultAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.defaultAddressButton.titleLabel setFont:PersonalManagerAddrestSaveButtonFont];
    [self.view addSubview:self.defaultAddressButton];
    
    __weak typeof(self)weakSelf = self;
    [self.tableView makeConstraints:^(MASConstraintMaker* make){
        make.leading.equalTo(weakSelf.view.leading);
        make.trailing.equalTo(weakSelf.view.trailing);
        make.top.equalTo(weakSelf.view.top);
        make.bottom.equalTo(weakSelf.defaultAddressButton.top);
    }];
    
    [self.defaultAddressButton makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.view.leading);
        make.trailing.equalTo(weakSelf.view.trailing);
        make.bottom.equalTo(weakSelf.view.bottom);
        make.height.equalTo(@(PersonalAddressDetailDefaultButtonHeight));
    }];
    
    self.tableView.backgroundColor      = Global_TableViewBackgroundColor;
    self.tableView.delegate             = self;
    self.tableView.dataSource           = self;
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleBordered target:self action:@selector(modifyButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark - 点击事件

//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] hideTabbar];
}

-(void)defaultAddressButtonClick{
    
}

-(void)modifyButtonClick{
    PersonalManageerAddressViewController *vc = [[PersonalManageerAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    self.dataTypeArr = @[@[@(PersonalAddressDetailCellType_consignee),
                           @(PersonalAddressDetailCellType_telephone),
                           @(PersonalAddressDetailCellType_area),
                           @(PersonalAddressDetailCellType_detailAddress),],
                         @[@(PersonalAddressDetailCellType_delete)]
                         ].mutableCopy;
    
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalAddressDetailTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:tableViewDetailTableViewCellReuseIdentifier];
    
}


#pragma mark - 
-(PersonalAddressDetailCellType)getSpercificTypeWithIndexPath:(NSIndexPath*)indexPath{
    PersonalAddressDetailCellType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *tempArr = self.dataTypeArr[indexPath.section];
        if(tempArr.count>indexPath.row){
            type = (PersonalAddressDetailCellType)[tempArr[indexPath.row] integerValue];
        }
    }
    return type;
}

#pragma mark - UITableViewDelegateAndDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataTypeArr.count>section){
        NSArray *tempArr = self.dataTypeArr[section];
        return tempArr.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataTypeArr.count;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = PersonalAddrestDetailCellHeight;
    
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.1;
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    PersonalAddressDetailTableViewCell *addressCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewDetailTableViewCellReuseIdentifier forIndexPath:indexPath];
    PersonalAddressDetailCellType type = [self getSpercificTypeWithIndexPath:indexPath];
    [addressCell resetValueWithType:type];
    if(type == PersonalAddressDetailCellType_delete){
        [addressCell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    else{
        [addressCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell = (UITableViewCell*)addressCell;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

@end
