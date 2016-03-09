//
//  PersonalAgeViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAgeViewController.h"
#import "UIColor+Addition.h"
#import "PersonalMacro.h"
#import "PersonalAgeTableViewCell.h"
#import "AppDelegate.h"
#import "NSArray+Addition.h"

static NSString *personalAgeCellIndentifier = @"personalAgeCellIndentifier";
static NSInteger maxAge = 100;

@interface PersonalAgeViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong,nonatomic) NSMutableArray *pickerViewData;
@property (assign,nonatomic)NSInteger selectedAge;
@end

@implementation PersonalAgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self navigationItemConfig];
    [self registerCellNib];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self pickerViewScrollToSpecificRow];
}

-(void)pickerViewScrollToSpecificRow{
    AVUser *user = [AVUser currentUser];
    if(user.age.length>0){
        NSInteger row = [user.age integerValue];
        if(self.pickerViewData.count>row){
            [self.pickerView selectRow:row inComponent:0 animated:YES];
        }
    }
    
}

#pragma mark - UI

-(void)UIConfig{
    self.title = @"年龄";
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = PersonalTableViewBackgroundColor;
    self.selectedAge = -1;
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerViewData = @[].mutableCopy;
    for (NSInteger i = 0; i <= maxAge; i++) {
        [self.pickerViewData addObject:@(i)];
    }
}

-(void)navigationItemConfig{
    NSArray *left                  = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    UIBarButtonItem *right                 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveButtonClick{
    AVUser *user = [AVUser currentUser];
    if(user){
        user.age = [NSString stringWithFormat:@"%ld",(long)self.selectedAge];
        if(self.delegate && [self.delegate respondsToSelector:@selector(userPropertySave)]){
            [self.delegate userPropertySave];
            [self returnButtonClick];
        }
    }
}

//tableViewCell分割线左边距为0
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,PersonalTableViewCellLeftSeparatorInset,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,PersonalTableViewCellLeftSeparatorInset,0,0)];
    }
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalAgeTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:personalAgeCellIndentifier];
    
}

#pragma mark - UITableViewDelegateAndDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PersonalNormalCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = PersonalTableViewSectionHeaderHeight;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), height)];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return PersonalTableViewSectionHeaderHeight;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    PersonalAgeTableViewCell *ageCell = [self.tableView dequeueReusableCellWithIdentifier:personalAgeCellIndentifier forIndexPath:indexPath];
    cell = (UITableViewCell*)ageCell;
    
    if(self.selectedAge>0){
        [ageCell fillDetailWithAge:self.selectedAge];
    }
    else{
        [ageCell detailConfig];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

#pragma mark - pickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerViewData.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    if(self.pickerViewData.count>row){
        return [NSString stringWithFormat:@"%ld",(long)[self.pickerViewData[row] integerValue]];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if(self.pickerViewData.count>row){
        self.selectedAge = [self.pickerViewData[row] integerValue];
        [self.tableView reloadData];
    }
}

@end
