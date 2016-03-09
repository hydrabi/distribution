//
//  PersonalSettingFunctionViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalSettingFunctionViewController.h"
#import "PersonalSettingFunctionMacro.h"
#import "NSArray+Addition.h"
#import "UIColor+Addition.h"
#import "PersonalSettingTableViewCell.h"

static NSString *personalSettingTableViewCellIdentifier = @"personalSettingTableViewCellIdentifier";
static NSString *personalSettingNormalTableViewCellIdentifier = @"personalSettingNormalTableViewCellIdentifier";

@interface PersonalSettingFunctionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@property (nonatomic,strong)UISwitch *mySwitch;
@end

@implementation PersonalSettingFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self registerNib];
    [self navigationConfig];
}

-(void)UIConfig{
    self.title = @"设置";
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = PersonalSettingFunctionTableViewBackgroundColor;
    
    self.mySwitch = [[UISwitch alloc] init];
    NSNumber *on = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultKey_PersonalSettingFunctionSetingWifiShowImage];
    if([on boolValue]){
        self.mySwitch.on = YES;
    }
    else{
        self.mySwitch.on = NO;
    }
    [self.mySwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.dataTypeArr = @[@[@(PersonalSettingTypeWifiShowImage),
                           @(PersonalSettingTypeClearCache)]
                         ,@[@(PersonalSettingTypeEvaluate),
                            @(PersonalSettingTypeAboutUs)]].mutableCopy;
}

-(void)navigationConfig{
    NSArray *left                  = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
}

-(void)registerNib{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([PersonalSettingTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:personalSettingTableViewCellIdentifier];
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)switchValueChange:(UISwitch*)sender{
    if(self.mySwitch.isOn){
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:UserDefaultKey_PersonalSettingFunctionSetingWifiShowImage];
        
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:UserDefaultKey_PersonalSettingFunctionSetingWifiShowImage];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**获取指定indexPath的type*/
-(PersonalSettingType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    PersonalSettingType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *arr = self.dataTypeArr[indexPath.section];
        if(arr.count>indexPath.row){
            type = (PersonalSettingType)[arr[indexPath.row] integerValue];
            
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
    
    return 44;
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
    PersonalSettingType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    switch (type) {
        case PersonalSettingTypeWifiShowImage:
        {
            UITableViewCell *wifiCell = [self.tableView dequeueReusableCellWithIdentifier:personalSettingNormalTableViewCellIdentifier];
            if(!wifiCell){
                wifiCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalSettingNormalTableViewCellIdentifier];
            }
            wifiCell.textLabel.text = @"仅在WiFi下显示图片";
            wifiCell.textLabel.textColor = [UIColor colorWithHexString:@"3f3f3f" alpha:1];
            wifiCell.accessoryView = self.mySwitch;
            [wifiCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return wifiCell;
        }
            break;
        default:
        {
            PersonalSettingTableViewCell *settingCell = [self.tableView dequeueReusableCellWithIdentifier:personalSettingTableViewCellIdentifier forIndexPath:indexPath];
            [settingCell resetValueWithType:type];
            return settingCell;
        }
            break;
            
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
