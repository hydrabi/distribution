//
//  ClassifyView.m
//  Distribution
//
//  Created by Hydra on 16/3/8.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ClassifyView.h"
#import "UIColor+Addition.h"
#import "ClassifyViewTableViewCell.h"
#import "ClassifyViewMacro.h"
#import "ClassifyViewTableViewHeader.h"


static NSString *tableViewCellIdentifier = @"tableViewCellIdentifier";

@interface ClassifyView ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak)UIView *parentView;
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@property (nonatomic,strong)ClassifyViewTableViewHeader *tableViewHeader;
@end

@implementation ClassifyView


-(instancetype)initWithParentView:(UIView*)parentView{
    self = [super initWithFrame:parentView.frame];
    if(self){
        self.parentView = parentView;
        [self initilizeWithFrame:parentView.frame];
    }
    return self;
}

-(void)initilizeWithFrame:(CGRect)frame{
    self.dataTypeArr = @[@(productType_overcoat),
                         @(productType_trousers),
                         @(productType_sweater),
                         @(productType_dress)].mutableCopy;
    
    self.backgroundColor = blurBackgroupColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame), 0, tableViewWidth, CGRectGetHeight(frame)) style:UITableViewStyleGrouped];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ClassifyViewBackgroundColor;
    [self registerNib];
    [self addSubview:self.self.tableView];
    [self.tableView reloadData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

-(ClassifyViewTableViewHeader*)tableViewHeader{
    if(!_tableViewHeader){
        _tableViewHeader = [[ClassifyViewTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), ClassifyTableViewHeaderHeight)];
    }
    return _tableViewHeader;
}

#pragma mark - 展示或隐藏
-(void)show{
    if(self.parentView && !self.superview){
        [self.parentView addSubview:self];
        self.tableView.hidden = NO;

        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.tableView.frame = CGRectMake(CGRectGetWidth(self.frame)-tableViewWidth, 0, tableViewWidth, CGRectGetHeight(self.frame));
                         }completion:^(BOOL finish){
                             [self.tableViewHeader loginStatusChange];
                         }];
    }
}

-(void)hide{
    if(self.superview){
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.tableView.frame = CGRectMake(CGRectGetWidth(self.frame), 0, tableViewWidth, CGRectGetHeight(self.frame));
                         }completion:^(BOOL finish){
                             self.tableView.hidden = YES;
                             if(self.superview){
                                 [self removeFromSuperview];
                             }
                         }];
    }
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    CGPoint location = [tap locationInView:self];
    if(!CGRectContainsPoint(self.tableView.frame, location)){
        [self hide];
    }
}

#pragma mark - tableView delegate && dataSource
-(void)registerNib{
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([ClassifyViewTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:tableViewCellIdentifier];
}

-(productType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    productType type;
    
    if(self.dataTypeArr.count>indexPath.row){
        type = (productType)[self.dataTypeArr[indexPath.row] integerValue];
    }
    
    return type;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataTypeArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ClassifyTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.tableViewHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = ClassifyTableViewHeaderHeight;
    return height;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    CGFloat height = 0.1;
//    
//    return height;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    productType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    
    ClassifyViewTableViewCell *classifyCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier forIndexPath:indexPath];
    [classifyCell resetValueWithType:type];
    cell = (UITableViewCell*)classifyCell;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    productType type = [self getSpecificCellTypeWithIndexPath:indexPath];
//    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowOfPersonalMainDataType:)]){
//        [self.delegate didSelectRowOfPersonalMainDataType:type];
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint location = [gestureRecognizer locationInView:self];
    if(CGRectContainsPoint(self.tableView.frame, location)){
        return NO;
    }
    else{
        return YES;
    }
}

@end
