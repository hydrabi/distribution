//
//  CustomBaseProductListDataSource.m
//  Distribution
//
//  Created by Hydra on 16/3/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomBaseProductListDataSource.h"
#import "CustomBaseProductListMacro.h"
#import "FavoriteTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MJRefresh.h"

static NSString *tableViewFavoriteCellIndentifier = @"tableViewFavoriteCellIndentifier";

@interface CustomBaseProductListDataSource()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation CustomBaseProductListDataSource

-(instancetype)initWithTableView:(UITableView*)tableView{
    self = [super init];
    if(self){
        self.tableView                      = tableView;
        self.tableView.delegate             = self;
        self.tableView.dataSource           = self;

        self.tableView.emptyDataSetSource   = self;
        self.tableView.emptyDataSetDelegate = self;

        self.dataTypeArr                    = [[NSMutableArray alloc] init];
        [self registerCellNib];
    }
    return self;
}

-(void)reloadTableViewData{
    [self.tableView reloadData];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewFavoriteCellNib = [UINib nibWithNibName:NSStringFromClass([FavoriteTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewFavoriteCellNib forCellReuseIdentifier:tableViewFavoriteCellIndentifier];
}

#pragma mark - UITableViewDelegateAndDataSource

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(titleForDeleteConfirmationButtonForRowAtIndexPath:)]){
        return [self.delegate titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataTypeArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ProductListTableViewCellHeight;
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
        [cell setSeparatorInset:UIEdgeInsetsMake(0, ProductListTableViewCellLeftSeparatorInset, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, ProductListTableViewCellLeftSeparatorInset, 0, 0)];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(editingStyleForRowAtIndexPath:)]){
        return [self.delegate editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

//删除收藏
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if([self.delegate respondsToSelector:@selector(commitEditingStyle:forRowAtIndexPath:)]){
            [self.delegate commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
        }

        [self.dataTypeArr removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
        
        if(self.dataTypeArr.count == 0){
            [tableView reloadData];
        }
    }
}

@end
