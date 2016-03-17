//
//  CustomRegisterSecondStepViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomRegisterSecondStepViewController.h"
#import "CustomPrefixInputTextFieldTableViewCell.h"
@interface CustomRegisterSecondStepViewController ()
@property (nonatomic,weak)UITextField *passwordTextField;
@end

@implementation CustomRegisterSecondStepViewController

+(instancetype)shareInstance{
    static CustomRegisterSecondStepViewController *registerSecondView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registerSecondView = [[CustomRegisterSecondStepViewController alloc] initWithType:AccountReleateViewControllerType_RegisterSecond];
    });
    return registerSecondView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIConfig{
    [super UIConfig];
    self.title = @"注册";
}


-(void)returnButtonClick{
    [super returnButtonClick];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)configDataTypeArr{
    [super configDataTypeArr];
    self.dataTypeArr = @[@(AccountReleateCellType_registerSettingPassword)].mutableCopy;
}

-(void)mainButtonClick{
    
}

-(void)subButtonClick{
    
}

#pragma mark - tableviewDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    AccountReleateCellType type = [self getSpecificTypeWithIndexPath:indexPath];
    switch (type) {
        case AccountReleateCellType_registerSettingPassword:
        {
            CustomPrefixInputTextFieldTableViewCell *passwordCell = [tableView dequeueReusableCellWithIdentifier:customPrefixInputTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.passwordTextField = passwordCell.textField;
            [passwordCell setType:type];
            cell = (UITableViewCell*)passwordCell;
        }
            break;
        
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
