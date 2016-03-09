//
//  DiscoverTableViewDataSource.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverTableViewDataSource.h"
#import "DiscoverTableViewCell.h"
static NSString *tableViewNormalCellIndentifier = @"tableViewNormalCellIndentifier";

@interface DiscoverTableViewDataSource()

/**
 *  从about中传递过来的tableView
 */
@property (nonatomic,weak) UITableView *tableView;

/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;

@end

@implementation DiscoverTableViewDataSource

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
    [self.dataTypeArr addObject: @[@(DiscoverTableDataType_service)
                                   ]
     ];
    [self.dataTypeArr addObject:@[@(DiscoverTableDataType_notification),
                                  @(DiscoverTableDataType_newActivity)]
     ];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewNormalCellNib = [UINib nibWithNibName:NSStringFromClass([DiscoverTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNormalCellNib forCellReuseIdentifier:tableViewNormalCellIndentifier];
}

/**获取指定indexPath的type*/
-(DiscoverTableDataType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    DiscoverTableDataType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *arr = self.dataTypeArr[indexPath.section];
        if(arr.count>indexPath.row){
            type = (DiscoverTableDataType)[arr[indexPath.row] integerValue];
            
        }
    }
    return type;
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
    
    return DiscoverTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = DiscoverTableViewHeaderHeight;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), height)];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return DiscoverTableViewHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableDataType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    DiscoverTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableViewNormalCellIndentifier forIndexPath:indexPath];
    cell.dataType = type;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscoverTableDataType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowOfDiscoverDataType:)]){
        [self.delegate didSelectRowOfDiscoverDataType:type];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
