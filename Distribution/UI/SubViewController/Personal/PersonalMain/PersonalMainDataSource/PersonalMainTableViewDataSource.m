//
//  PersonalMainTableViewDataSource.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainTableViewDataSource.h"
#import "PersonalMainNameTableViewCell.h"
#import "PersonalMainOrderTableViewCell.h"
#import "PersonalMainNormalTableViewCell.h"
#import "PersonalMainOrderHeaderTableViewCell.h"
#import "PersonalMainMacro.h"
#import "PersonalMainTableViewHeader.h"
static NSString *tableViewNameCellIndentifier = @"tableViewNameCellIndentifier";
static NSString *tableViewOrderCellIndentifier = @"tableViewOrderCellIndentifier";
static NSString *tableViewNormalCellIndentifier = @"tableViewNormalCellIndentifier";
static NSString *tableViewOrderHeaderCellIndentifier = @"tableViewOrderHeaderCellIndentifier";

@interface PersonalMainTableViewDataSource()
/**
 *  从about中传递过来的tableView
 */
@property (nonatomic,weak) UITableView *tableView;

/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@end

@implementation PersonalMainTableViewDataSource

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
    }
    return self;
}

#pragma mark - 刷新tableView
-(void)reloadTableViewData{
    [self.tableView reloadData];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    [self.dataTypeArr addObject:@[@(PersonalMainTableDataType_name)]];
    [self.dataTypeArr addObject:@[@(PersonalMainTableDataType_orderHeader),
                                  @(PersonalMainTableDataType_order)]];
    [self.dataTypeArr addObject:@[@(PersonalMainTableDataType_footprint),
                                  @(PersonalMainTableDataType_location),
                                  @(PersonalMainTableDataType_telephone)]];
    [self.dataTypeArr addObject:@[@(PersonalMainTableDataType_setting)]];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewNormalCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalMainNormalTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNormalCellNib forCellReuseIdentifier:tableViewNormalCellIndentifier];
    
    UINib *tableViewNameCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalMainNameTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNameCellNib forCellReuseIdentifier:tableViewNameCellIndentifier];
    
    UINib *tableViewOrderCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalMainOrderTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewOrderCellNib forCellReuseIdentifier:tableViewOrderCellIndentifier];
    
    UINib *tableViewOrderHeaderCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalMainOrderHeaderTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewOrderHeaderCellNib forCellReuseIdentifier:tableViewOrderHeaderCellIndentifier];
}

/**获取指定indexPath的type*/
-(PersonalMainTableDataType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    PersonalMainTableDataType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *arr = self.dataTypeArr[indexPath.section];
        if(arr.count>indexPath.row){
            type = (PersonalMainTableDataType)[arr[indexPath.row] integerValue];
            
        }
    }
    return type;
}

#pragma mark - 获取相应的cell高度
-(CGFloat)heightWithPersonalMainTableDataType:(PersonalMainTableDataType)type{
    CGFloat height = 0;
    switch (type) {
        case PersonalMainTableDataType_name:
            height = PersonalMainNameTableViewCellHeight;
            break;
        case PersonalMainTableDataType_order:
            height = PersonalMainOrderTableViewCellHeight;
            break;
        case PersonalMainTableDataType_orderHeader:
            height = PersonalMainOrderHeaderTableViewHeight;
            break;
        default:
            height = PersonalMainNormalTableViewCellHeight;
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
    
    return [self heightWithPersonalMainTableDataType:[self getSpecificCellTypeWithIndexPath:indexPath]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

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
    PersonalMainTableDataType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    switch (type) {
        case PersonalMainTableDataType_name:
        {
            PersonalMainNameTableViewCell *nameCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewNameCellIndentifier forIndexPath:indexPath];
            [nameCell reloadUserData];
            cell = (UITableViewCell*)nameCell;
        }
            break;
        case PersonalMainTableDataType_order:
        {
            PersonalMainOrderTableViewCell *orderCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewOrderCellIndentifier forIndexPath:indexPath];
            //设置不能选中
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = (UITableViewCell*)orderCell;
        }
            break;
            
        case PersonalMainTableDataType_orderHeader:
        {
            PersonalMainOrderHeaderTableViewCell *orderHeaderCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewOrderHeaderCellIndentifier forIndexPath:indexPath];
            //设置不能选中
            orderHeaderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = (UITableViewCell*)orderHeaderCell;
        }
            break;
        default:
        {
            PersonalMainNormalTableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewNormalCellIndentifier forIndexPath:indexPath];
            normalCell.dataType = type;
            cell = (UITableViewCell*)normalCell;
            
        }
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalMainTableDataType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowOfPersonalMainDataType:)]){
        [self.delegate didSelectRowOfPersonalMainDataType:type];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
