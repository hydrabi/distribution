//
//  PersonalTableViewDataSource.m
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PersonalTableViewDataSource.h"
#import "PersonalHeaderCell.h"
#import "PersonalNormalCell.h"
#import "PersonalMacro.h"
#import "PersonalTableViewFooter.h"
#import "AppDelegate.h"
#import "PersonalMacro.h"

static NSString *tableViewNormalCellIndentifier = @"tableViewNormalCellIndentifier";
static NSString *tableViewHeadCellIndentifier = @"tableViewHeadCellIndentifier";

@interface PersonalTableViewDataSource()

/**
 *  从about中传递过来的tableView
 */
@property (nonatomic,weak) UITableView *tableView;

/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
/**
 *  退出按钮
 */
@property (nonatomic,strong)PersonalTableViewFooter *tableViewFooter;

@end

@implementation PersonalTableViewDataSource

#pragma mark - 初始化

-(instancetype)initWithTableView:(UITableView*)tableView{
    self = [super init];
    if(self){
        self.tableView            = tableView;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        
        self.dataTypeArr = [[NSMutableArray alloc] init];
        [self configDataTypeArr];
        [self registerCellNib];
        [self tableViewFooterConfig];
    }
    return self;
}

-(void)tableViewFooterConfig{
    if(!_tableViewFooter){
        _tableViewFooter = [PersonalTableViewFooter instancePersonalTableViewFooter];
        _tableViewFooter.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), PersonalTableViewFooterHeight);
        [_tableViewFooter.logoutButton addTarget:self action:@selector(footerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        if([[PersonlInfoManager shareManager] hadLogin]){
            [_tableViewFooter setLogout];
        }
        else{
            [_tableViewFooter setLogin];
        }
        
    }
    self.tableView.tableFooterView = _tableViewFooter;
    
}

-(void)resetTableViewFooter{
    if([[PersonlInfoManager shareManager] hadLogin]){
        [_tableViewFooter setLogout];
    }
    else{
        [_tableViewFooter setLogin];
    }
}

#pragma mark - 登录或者登出按钮点击
-(void)footerButtonClick{
    if([[PersonlInfoManager shareManager] hadLogin]){
        [[PersonlInfoManager shareManager] logoutPrepare];
        [[PersonlInfoManager shareManager] logoutWithBlock:^(BOOL success){
            if(success){
                [self.tableViewFooter setLogin];
                [self.tableView reloadData];
            }
        }];
    }
    else{
        [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_Login];
    }
}

#pragma mark - 刷新tableView
-(void)reloadTableViewData{
    [self.tableView reloadData];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    [self.dataTypeArr addObject: @[@(PersonalTableDataType_head)
                                   ]
     ];
    
    [self.dataTypeArr addObject: @[@(PersonalTableDataType_nickname),
                                   @(PersonalTableDataType_age),
                                   @(PersonalTableDataType_gender),
                                   @(PersonalTableDataType_weixin),
                                   @(PersonalTableDataType_qq),
                                   @(PersonalTableDataType_telephone)]
     ];
    
    [self.dataTypeArr addObject: @[@(PersonalTableDataType_location),
                                   @(PersonalTableDataType_manageAdress),
                                   @(PersonalTableDataType_modifyPassword),
                                   ]
     ];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewNormalCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalNormalCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNormalCellNib forCellReuseIdentifier:tableViewNormalCellIndentifier];
    
    UINib *tableViewHeadCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalHeaderCell class]) bundle:nil];
    [self.tableView registerNib:tableViewHeadCellNib forCellReuseIdentifier:tableViewHeadCellIndentifier];
}

/**获取指定indexPath的type*/
-(PersonalTableDataType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    PersonalTableDataType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *arr = self.dataTypeArr[indexPath.section];
        if(arr.count>indexPath.row){
            type = (PersonalTableDataType)[arr[indexPath.row] integerValue];
            
        }
    }
    return type;
}

#pragma mark - 获取响应的title
-(NSString *)titleWithPersonalTableDataType:(PersonalTableDataType)type{
    NSString *title = @"";
    switch (type) {
        case PersonalTableDataType_head:
            title = @"编辑头像";
            break;
        case PersonalTableDataType_age:
            title = @"年龄";
            break;
        case PersonalTableDataType_gender:
            title = @"性别";
            break;
        case PersonalTableDataType_location:
            title = @"位置";
            break;
        case PersonalTableDataType_telephone:
            title = @"联系电话";
            break;
        case PersonalTableDataType_nickname:
            title = @"昵称";
            break;
        case PersonalTableDataType_weixin:
            title = @"微信";
            break;
        case PersonalTableDataType_qq:
            title = @"QQ";
            break;
        case PersonalTableDataType_manageAdress:
            title = @"地址管理";
            break;
        case PersonalTableDataType_modifyPassword:
            title = @"修改密码";
            break;
        default:
            break;
    }
    return title;
}

#pragma mark - 获取相应的cell高度
-(CGFloat)heightWithPersonalTableDataType:(PersonalTableDataType)type{
    CGFloat height = 0;
    switch (type) {
        case PersonalTableDataType_head:
            height = PersonalHeadCellHeight;
            break;
        default:
            height = PersonalNormalCellHeight;
            break;
    }
    return height;
}

#pragma mark - UITableViewDelegateAndDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataTypeArr.count>section){
        NSArray *arr = self.dataTypeArr[section];
        return arr.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataTypeArr.count;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self heightWithPersonalTableDataType:[self getSpecificCellTypeWithIndexPath:indexPath]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = PersonalTableViewSectionHeaderHeight;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), height)];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return PersonalTableViewSectionHeaderHeight;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    PersonalTableDataType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    switch (type) {
        case PersonalTableDataType_head:
        {
            PersonalHeaderCell *headCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewHeadCellIndentifier forIndexPath:indexPath];
            cell = (UITableViewCell*)headCell;
            
            headCell.headLabel.text = [self titleWithPersonalTableDataType:type];
            [headCell detailConfig];
        }
            break;
        
        default:
        {
            PersonalNormalCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewNormalCellIndentifier forIndexPath:indexPath];
            cell = (UITableViewCell*)normalCell;
            
            normalCell.titleLable.text = [self titleWithPersonalTableDataType:type];
            [normalCell detailConfigWithType:type];
        }
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalTableDataType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowOfAboutDataType:)]){
        [self.delegate didSelectRowOfAboutDataType:type];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableViewCell分割线左边距为16
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, PersonalTableViewCellLeftSeparatorInset, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, PersonalTableViewCellLeftSeparatorInset, 0, 0)];
    }
}

@end
