//
//  PersonalGenderViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalGenderViewController.h"
#import "UIColor+Addition.h"
#import "PersonalMacro.h"
#import "AppDelegate.h"
#import "PersonalGenderTableViewCell.h"
#import "NSArray+Addition.h"

static NSString *personalGenderCellIndentifier = @"personalGenderCellIndentifier";

@interface PersonalGenderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;

@property (nonatomic,assign)PersonalGenderCellType selectedType;
@end

@implementation PersonalGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configDataTypeArr];
    [self UIConfig];
    [self navigationItemConfig];
    [self registerCellNib];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - UI

-(void)UIConfig{
    self.title = @"性别";
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = PersonalTableViewBackgroundColor;
    
    AVUser *user = [AVUser currentUser];
    if(user){
        self.selectedType = [self typeWithTitle:user.gender];
    }
    else{
        self.selectedType = PersonalGenderCellType_male;
    }
    
}

-(void)navigationItemConfig{
    NSArray *left                  = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
    
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveButtonClick{
    AVUser *user = [AVUser currentUser];
    if(user){
        NSString *gender = [self titleWithPersonalTableDataType:self.selectedType];
        user.gender = gender;
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

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    self.dataTypeArr = @[].mutableCopy;
    [self.dataTypeArr addObject: @[@(PersonalGenderCellType_male),
                                   @(PersonalGenderCellType_female),
                                   ]
     ];
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalGenderTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:personalGenderCellIndentifier];
    
}

#pragma mark - 获取响应的title
-(NSString *)titleWithPersonalTableDataType:(PersonalGenderCellType)type{
    NSString *title = @"";
    switch (type) {
        case PersonalGenderCellType_female:
            title = @"女";
            break;
        case PersonalGenderCellType_male:
            title = @"男";
            break;
            
        default:
            break;
    }
    return title;
}

-(PersonalGenderCellType)typeWithTitle:(NSString*)title{
    PersonalGenderCellType type;
    if(title.length>0){
        if([title isEqualToString:@"女"]){
            type = PersonalGenderCellType_female;
        }
        else{
            type = PersonalGenderCellType_male;
        }
    }
    return type;
}

/**获取指定indexPath的type*/
-(PersonalGenderCellType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    PersonalGenderCellType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *arr = self.dataTypeArr[indexPath.section];
        if(arr.count>indexPath.row){
            type = (PersonalGenderCellType)[arr[indexPath.row] integerValue];
            
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
    
    PersonalGenderTableViewCell *genderCell = [self.tableView dequeueReusableCellWithIdentifier:personalGenderCellIndentifier forIndexPath:indexPath];
    cell = (UITableViewCell*)genderCell;
    
    PersonalGenderCellType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    genderCell.titleLabel.text = [self titleWithPersonalTableDataType:type];
    
    if(type == self.selectedType){
        genderCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        genderCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalGenderCellType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    self.selectedType = type;
    [self saveButtonClick];
    
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
