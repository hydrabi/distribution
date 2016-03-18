//
//  CustomRegisterSecondStepViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomRegisterSecondStepViewController.h"
#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "PersonlInfoManager.h"
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
    
    if(self.passwordTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入密码!"];
        return;
    }
    
    if(self.passwordTextField.text.length<6 || self.passwordTextField.text.length>12){
        [MBProgressHUD showError:@"密码长度大于或等于6位且不超过12位!"];
        return;
    }
    
    [self registerPrepare];
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

#pragma mark - register
-(void)registerPrepare{
    [self.view endEditing:YES];
    [self registerRequest];
}

//注册请求
-(void)registerRequest{
    //leanClound验证验证码
    [[PersonlInfoManager shareManager] leanCloudVerifyVerifyCodeWith:self.verifyCode telephone:self.telephone completiton:^(BOOL success,NSError *error){
        if(success){
            //成功后环信注册
            [[PersonlInfoManager shareManager] registerWithTelephoneNumber:self.telephone password:self.passwordTextField.text completiton:^(BOOL success){
                [self registerCompleteWithResult:success];
            }];
        }
        else{
            [MBProgressHUD showError:@"验证码验证失败！"];
            NSLog(@"验证码验证失败！");
        }
        
    }];
    
    
//    不通过验证码注册，测试用
//    [[PersonlInfoManager shareManager] registerWithTelephoneNumber:self.telephone password:self.passwordTextField.text completiton:^(BOOL success){
//        [self registerCompleteWithResult:success];
//    }];
}

-(void)registerCompleteWithResult:(BOOL)result{
    if(result){
        [MBProgressHUD showSuccess:@"注册成功"];
        [[AccountNavigationManager shareInstance] hideNavWithCompletion:^{
            [[AccountNavigationManager shareInstance] clearRegisterTextField];
        }];
    }
    else{
        [MBProgressHUD showError:@"注册失败"];
    }
    
}

@end
