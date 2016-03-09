//
//  SearchProductDataSource.m
//  Distribution
//
//  Created by Hydra on 16/3/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "SearchProductDataSource.h"
#import "FavoriteMacro.h"
#import "FavoriteTableViewCell.h"
static NSString *tableViewFavoriteCellIndentifier = @"tableViewFavoriteCellIndentifier";
@interface SearchProductDataSource()
/**
 *  从about中传递过来的tableView
 */
@property (nonatomic,weak) UITableView *tableView;

/**
 *  数据源列表
 */
@property (nonatomic,strong)NSArray *dataTypeArr;
@end

@implementation SearchProductDataSource

-(instancetype)initWithTableView:(UITableView*)tableView dataArr:(NSArray *)dataArr{
    self = [super init];
    if(self){
        self.tableView            = tableView;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
    
        self.dataTypeArr = dataArr;
        [self registerCellNib];
    }
    return self;
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewFavoriteCellNib = [UINib nibWithNibName:NSStringFromClass([FavoriteTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewFavoriteCellNib forCellReuseIdentifier:tableViewFavoriteCellIndentifier];
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
    
    return FavoriteTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    FavoriteTableViewCell *favoriteCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewFavoriteCellIndentifier forIndexPath:indexPath];
    cell = (UITableViewCell*)favoriteCell;
    if(self.dataTypeArr.count>indexPath.row){
        AVObject *object = self.dataTypeArr[indexPath.row];
        [favoriteCell resetValueWithObject:object];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowWithObject:)]){
        if(self.dataTypeArr.count>indexPath.row){
            AVObject *object = self.dataTypeArr[indexPath.row];
            [self.delegate didSelectRowWithObject:object];
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableViewCell分割线左边距为12
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, FavoriteTableViewCellLeftSeparatorInset, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, FavoriteTableViewCellLeftSeparatorInset, 0, 0)];
    }
}

@end
