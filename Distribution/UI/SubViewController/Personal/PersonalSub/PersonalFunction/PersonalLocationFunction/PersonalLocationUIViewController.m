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
        
        NSInteger stateRow = [user.locationDic[AreaState] integerValue];
        NSInteger cityRow = [user.locationDic[AreaCity] integerValue];
        NSInteger disRow = [user.locationDic[AreaDistricts] integerValue];
        
        self.cityArr = self.provinceArr[stateRow][@"cities"];
        self.areaArr = self.cityArr[cityRow][@"areas"];
        [self.pickerView reloadAllComponents];
        
        [self.pickerView selectRow:stateRow inComponent:0 animated:NO];
        [self.pickerView selectRow:cityRow inComponent:1 animated:NO];
        if(disRow>0){
            [self.pickerView selectRow:disRow inComponent:2 animated:NO];
        }
        
        self.locate.state = self.provinceArr[stateRow][@"state"];
        self.locate.city = self.cityArr[cityRow][@"city"];
        if (disRow>0) {
            self.locate.district = self.areaArr[disRow];
        }else{
            self.locate.district = @"";
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
    self.provinceArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]].mutableCopy;
    self.cityArr = self.provinceArr[0][@"cities"];
    self.areaArr = self.cityArr[0][@"areas"];
    
    self.locateDic = @{}.mutableCopy;
    AVUser *user = [AVUser currentUser];
    if(user.locationDic){
        self.locateDic = [NSMutableDictionary dictionaryWithDictionary:user.locationDic];
    }
    else{
        [self.locateDic setObject:@(0) forKey:AreaState];
        [self.locateDic setObject:@(0) forKey:AreaCity];
        [self.locateDic setObject:@(0) forKey:AreaDistricts];
    }

    self.locate.state = self.provinceArr[0][@"state"];
    self.locate.city = self.cityArr[0][@"city"];
    if (self.areaArr.count) {
        self.locate.district = self.areaArr[0];
    }else{
        self.locate.district = @"";
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
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            return self.areaArr.count;
            break;
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
            return [[self.provinceArr objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[self.cityArr objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if (self.areaArr.count>row) {
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
            self.cityArr = self.provinceArr[row][@"cities"];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.state = self.provinceArr[row][@"state"];
            self.locate.city = self.cityArr[0][@"city"];
            if (self.areaArr.count>0) {
                self.locate.district = self.areaArr[0];
            }else{
                self.locate.district = @"";
            }
            
            [self.locateDic setObject:@(row) forKey:AreaState];
            [self.locateDic setObject:@(0) forKey:AreaCity];
            [self.locateDic setObject:@(0) forKey:AreaDistricts];
            
            break;
        }
        case 1:
        {
//            self.cityArr = [[self.provinceArr objectAtIndex:row] objectForKey:@"cities"];
//            [self.pickerView reloadComponent:2];
//            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            
            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.city = self.cityArr[row][@"city"];
            if (self.areaArr.count>0) {
                self.locate.district = self.areaArr[0];
            }else{
                self.locate.district = @"";
            }
            
            [self.locateDic setObject:@(row) forKey:AreaCity];
            [self.locateDic setObject:@(0) forKey:AreaDistricts];
        }
            break;
        case 2:
        {
//            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
//            [self.pickerView reloadComponent:3];
//            [self.pickerView selectRow:0 inComponent:3 animated:YES];
            
//            self.locate.city = self.cityArr[row][@"city"];
            if (self.areaArr.count>0) {
                self.locate.district = self.areaArr[row];
            }else{
                self.locate.district = @"";
            }
            
            [self.locateDic setObject:@(row) forKey:AreaDistricts];
        }
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}


@end
