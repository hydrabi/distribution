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
#import "PersonlInfoManager.h"
@interface CustomForgetPasswordViewController ()<VerifyButtonTextFieldTableViewCellDelegate,UITextFieldDelegate>
@property (nonatomic,weak)UITextField *telephoneTextField;
@property (nonatomic,weak)UITextField *virifyTextField;
@property (nonatomic,weak)UITextField *passwordTextField;
@property (nonatomic,weak)UIButton *verifyButton;
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
    if(self.telephoneTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    
    if(self.passwordTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入密码!"];
        return;
    }
    
    if(self.virifyTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入验证码!"];
        return;
    }
    
    if(self.passwordTextField.text.length<6 || self.passwordTextField.text.length>12){
        [MBProgressHUD showError:@"密码长度大于6位且不超过12位!"];
        return;
    }
    
    [self verifyPrepare];
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
            self.verifyButton = verifyCell.verifyButton;
            verifyCell.delegate = self;
            cell = (UITableViewCell*)verifyCell;
        }
            break;
        case AccountReleateCellType_forgetPasswordNewPassword:
        {
            CustomPrefixInputTextFieldTableViewCell *passwordCell = [tableView dequeueReusableCellWithIdentifier:customPrefixInputTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.passwordTextField = passwordCell.textField;
            self.passwordTextField.delegate = self;
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //done的返回键点击
    if(textField.returnKeyType == UIReturnKeyDone){
        [self mainButtonClick];
    }
    return YES;
}
#pragma mark - action
/**验证码按钮点击*/
-(void)verifyButtonClick:(void (^)(BOOL))callBack{
    
    if(self.telephoneTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    //获取验证码
    [[PersonlInfoManager shareManager] leanCloudRequestForgetPasswordVerifyCodeWithTelephone:self.telephoneTextField.text completiton:^(BOOL success,NSError *error){
        if(!error){
            [MBProgressHUD showSuccess:@"获取验证码成功！"];
        }
        else{
            [MBProgressHUD showError:@"获取验证码失败！"];
        }
    }];
    
    callBack(YES);
}

#pragma mark - 验证操作
//验证准备
-(void)verifyPrepare{
    [self.view endEditing:YES];
    [self verifyRequest];
}

//验证请求
-(void)verifyRequest{
    [[PersonlInfoManager shareManager] leanCloudVerifyForgetPasswordVerifyCodeWith:self.virifyTextField.text
                                                                         telephone:self.telephoneTextField.text
                                                                       newPassword:self.passwordTextField.text
                                                                       completiton:^(BOOL success,NSError *error){
                                                                           
                                                                           [self verifyCompleteWithResult:success];
                                                                       }];
}

-(void)verifyCompleteWithResult:(BOOL)result{
    if(result){
        [MBProgressHUD showSuccess:@"密码重置成功，请重新登录！"];
        [self clearTextField];
        [self returnButtonClick];
    }
    else{
        [MBProgressHUD showError:@"密码重置失败！"];
        NSLog(@"密码重置失败！");
        self.virifyTextField.text = @"";
    }
}

-(void)clearTextField{
    self.telephoneTextField.text = @"";
    self.passwordTextField.text = @"";
    self.virifyTextField.text = @"";
}

@end
