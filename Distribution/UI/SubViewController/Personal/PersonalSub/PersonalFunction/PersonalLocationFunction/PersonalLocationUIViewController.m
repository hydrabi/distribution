//
//  PersonalLocationUIViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalLocationUIViewController.h"
#import "UIColor+Addition.h"
#import "PersonalMacro.h"
#import "PersonalLocationUITableViewCell.h"
#import "AppDelegate.h"
#import "AreaObject.h"
#import "NSArray+Addition.h"

static NSString *personalLocationCellIndentifier = @"personalLocationCellIndentifier";

@interface PersonalLocationUIViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
//区域 数组
@property (strong, nonatomic) NSArray *regionArr;
//省 数组
@property (strong, nonatomic) NSMutableArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSMutableArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSMutableArray *areaArr;

@property (strong,nonatomic) NSMutableDictionary *locateDic;

@property (strong, nonatomic) AreaObject *locate;
@end

@implementation PersonalLocationUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self navigationItemConfig];
    [self registerCellNib];
    [self pickerDataConfig];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self pickerViewScrollToSpecificRow];
}

-(void)pickerViewScrollToSpecificRow{
    AVUser *user = [AVUser currentUser];
    if(user.locationDic){
        
        NSInteger regionRow = [user.locationDic[AreaRegion] integerValue];
        NSInteger provinceRow = [user.locationDic[AreaProvince] integerValue];
        NSInteger cityRow = [user.locationDic[AreaCity] integerValue];
        NSInteger disRow = [user.locationDic[AreaDistricts] integerValue];
        
        self.provinceArr = self.regionArr[regionRow][@"provinces"];
        self.cityArr = self.provinceArr[provinceRow][@"cities"];
        self.areaArr = self.cityArr[cityRow][@"areas"];
        [self.pickerView reloadAllComponents];
        
        [self.pickerView selectRow:regionRow inComponent:0 animated:NO];
        [self.pickerView selectRow:provinceRow inComponent:1 animated:NO];
        [self.pickerView selectRow:cityRow inComponent:2 animated:NO];
        if(disRow>0){
            [self.pickerView selectRow:disRow inComponent:3 animated:NO];
        }
        
        self.locate.region = self.regionArr[regionRow][@"region"];
        self.locate.province = self.provinceArr[provinceRow][@"province"];
        self.locate.city = self.cityArr[cityRow][@"city"];
        if (disRow>0) {
            self.locate.area = self.areaArr[disRow];
        }else{
            self.locate.area = @"";
        }
    }
    
}

#pragma mark - UI

-(void)UIConfig{
    self.title = @"位置";
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = PersonalTableViewBackgroundColor;
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
}

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

-(void)pickerDataConfig{
    self.regionArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaPlist.plist" ofType:nil]];
    self.provinceArr = self.regionArr[0][@"provinces"];
    self.cityArr = self.provinceArr[0][@"cities"];
    self.areaArr = self.cityArr[0][@"areas"];
    
    self.locateDic = @{}.mutableCopy;
    AVUser *user = [AVUser currentUser];
    if(user.locationDic){
        self.locateDic = user.locationDic;
    }
    else{
        [self.locateDic setObject:@(0) forKey:AreaRegion];
        [self.locateDic setObject:@(0) forKey:AreaProvince];
        [self.locateDic setObject:@(0) forKey:AreaCity];
        [self.locateDic setObject:@(0) forKey:AreaDistricts];
    }
    
    
    
    self.locate.region = self.regionArr[0][@"region"];
    self.locate.province = self.provinceArr[0][@"province"];
    self.locate.city = self.cityArr[0][@"city"];
    if (self.areaArr.count) {
        self.locate.area = self.areaArr[0];
    }else{
        self.locate.area = @"";
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
        user.location = [NSString stringWithFormat:@"%@",self.locate];
        user.locationDic = self.locateDic;
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
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalLocationUITableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:personalLocationCellIndentifier];
    
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
    
    PersonalLocationUITableViewCell *locationCell = [self.tableView dequeueReusableCellWithIdentifier:personalLocationCellIndentifier forIndexPath:indexPath];
    cell = (UITableViewCell*)locationCell;
    [locationCell fillDetailWithLocation:[NSString stringWithFormat:@"%@",self.locate]];
    
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
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.regionArr.count;
            break;
        case 1:
            return self.provinceArr.count;
            break;
        case 2:
            return self.cityArr.count;
            break;
        case 3:
            if (self.areaArr.count) {
                return self.areaArr.count;
                break;
            }
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    switch (component) {
        case 0:
            return [[self.regionArr objectAtIndex:row] objectForKey:@"region"];
            break;
        case 1:
            return [[self.provinceArr objectAtIndex:row] objectForKey:@"province"];
            break;
        case 2:
            return [[self.cityArr objectAtIndex:row] objectForKey:@"city"];
            break;
        case 3:
            if (self.areaArr.count) {
                return [self.areaArr objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    switch (component) {
        case 0:{
            self.provinceArr = self.regionArr[row][@"provinces"];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            
            self.cityArr = [[self.provinceArr objectAtIndex:0] objectForKey:@"cities"];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
            [self.pickerView reloadComponent:3];
            [self.pickerView selectRow:0 inComponent:3 animated:YES];
            
            self.locate.region = self.regionArr[row][@"region"];
            self.locate.province = self.provinceArr[0][@"province"];
            self.locate.city = self.cityArr[0][@"city"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            }else{
                self.locate.area = @"";
            }
            
            [self.locateDic setObject:@(row) forKey:AreaRegion];
            
            break;
        }
        case 1:
        {
            self.cityArr = [[self.provinceArr objectAtIndex:row] objectForKey:@"cities"];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
            [self.pickerView reloadComponent:3];
            [self.pickerView selectRow:0 inComponent:3 animated:YES];
            
            self.locate.province = self.provinceArr[row][@"province"];
            self.locate.city = self.cityArr[0][@"city"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            }else{
                self.locate.area = @"";
            }
            
            [self.locateDic setObject:@(row) forKey:AreaProvince];
            
            break;
        }
        case 2:{
            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
            [self.pickerView reloadComponent:3];
            [self.pickerView selectRow:0 inComponent:3 animated:YES];
            
            self.locate.city = self.cityArr[row][@"city"];
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            }else{
                self.locate.area = @"";
            }
            
            [self.locateDic setObject:@(row) forKey:AreaCity];
            
            break;
        }
        case 3:{
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[row];
                [self.locateDic setObject:@(row) forKey:AreaDistricts];
            }else{
                self.locate.area = @"";
                [self.locateDic setObject:@(-1) forKey:AreaDistricts];
            }
            
            break;
        }
        default:
            break;
    }
    
    [self.tableView reloadData];
}


@end
