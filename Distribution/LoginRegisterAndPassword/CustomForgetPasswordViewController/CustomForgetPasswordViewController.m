//
//  CustomForgetPasswordViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomForgetPasswordViewController.h"
#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "VerifyButtonTextFieldTableViewCell.h"
#import "AccountNavigationManager.h"
@interface CustomForgetPasswordViewController ()
@property (nonatomic,weak)UITextField *telephoneTextField;
@property (nonatomic,weak)UITextField *virifyTextField;
@property (nonatomic,weak)UITextField *passwordTextField;
@end

@implementation CustomForgetPasswordViewController

+(instancetype)shareInstance{
    static CustomForgetPasswordViewController *password = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        password = [[CustomForgetPasswordViewController alloc] initWithType:AccountReleateViewControllerType_forgetPassword];
    });
    return password;
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
    self.title = @"忘记密码";
}


-(void)returnButtonClick{
    [super returnButtonClick];
    [[AccountNavigationManager shareInstance] hideNavWithCompletion:^{
        
    }];
}

-(void)configDataTypeArr{
    [super configDataTypeArr];
    self.dataTypeArr = @[@(AccountReleateCellType_forgetPasswordTelephone),
                         @(AccountReleateCellType_forgetPasswordVerifyButton),
                         @(AccountReleateCellType_forgetPasswordNewPassword),].mutableCopy;
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
        case AccountReleateCellType_forgetPasswordTelephone:
        {
            CustomPrefixInputTextFieldTableViewCell *telephoneCell = [tableView dequeueReusableCellWithIdentifier:customPrefixInputTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.telephoneTextField = telephoneCell.textField;
            [telephoneCell setType:type];
            cell = (UITableViewCell*)telephoneCell;
        }
            break;
        case AccountReleateCellType_forgetPasswordVerifyButton:
        {
            VerifyButtonTextFieldTableViewCell *verifyCell = [tableView dequeueReusableCellWithIdentifier:verifyButtonTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.virifyTextField = verifyCell.textField;
            cell = (UITableViewCell*)verifyCell;
        }
            break;
        case AccountReleateCellType_forgetPasswordNewPassword:
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
