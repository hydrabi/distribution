//
//  CustomRegisterFirstStepViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/16.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomRegisterFirstStepViewController.h"
#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "VerifyButtonTextFieldTableViewCell.h"

@interface CustomRegisterFirstStepViewController ()<VerifyButtonTextFieldTableViewCellDelegate,UITextFieldDelegate>
@property (nonatomic,weak)UITextField *telephoneTextField;
@property (nonatomic,weak)UITextField *verifyTextField;
@property (nonatomic,weak)UIButton *verifyButton;
@end

@implementation CustomRegisterFirstStepViewController

+(instancetype)shareInstance{
    static CustomRegisterFirstStepViewController *registerFirstView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registerFirstView = [[CustomRegisterFirstStepViewController alloc] initWithType:AccountReleateViewControllerType_RegisterFirst];
    });
    return registerFirstView;
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
    [[AccountNavigationManager shareInstance] hideNavWithCompletion:^{
        [[AccountNavigationManager shareInstance] clearRegisterTextField];
    }];
}

-(void)configDataTypeArr{
    [super configDataTypeArr];
    self.dataTypeArr = @[@(AccountReleateCellType_registerTelephone),
                         @(AccountReleateCellType_registerVerifyButton)].mutableCopy;
}

-(void)mainButtonClick{
    if(self.telephoneTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    
    if(self.verifyTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入验证码!"];
        return;
    }
    
    [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_RegisterSecond];
}

#pragma mark - tableviewDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    AccountReleateCellType type = [self getSpecificTypeWithIndexPath:indexPath];
    switch (type) {
        case AccountReleateCellType_registerTelephone:
        {
            CustomPrefixInputTextFieldTableViewCell *telephoneCell = [tableView dequeueReusableCellWithIdentifier:customPrefixInputTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.telephoneTextField = telephoneCell.textField;
            [telephoneCell setType:type];
            cell = (UITableViewCell*)telephoneCell;
        }
            break;
        case AccountReleateCellType_registerVerifyButton:
        {
            VerifyButtonTextFieldTableViewCell *verifyCell = [tableView dequeueReusableCellWithIdentifier:verifyButtonTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.verifyTextField = verifyCell.textField;
            self.verifyButton = verifyCell.verifyButton;
            verifyCell.delegate = self;
            cell = (UITableViewCell*)verifyCell;
        }
            break;
        
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**验证码按钮点击*/
-(void)verifyButtonClick:(void (^)(BOOL))callBack{
    
    if(self.telephoneTextField.text.length == 0){
        [MBProgressHUD showError:@"请输入您的手机号!"];
        return;
    }
    
    //获取验证码
    [[PersonlInfoManager shareManager] leanCloudRequestVerifyCodeWithTelephone:self.telephoneTextField.text password:nil completiton:^(BOOL success,NSError *error){
        if(!error){
            [MBProgressHUD showSuccess:@"获取验证码成功！"];
        }
        else{
            [MBProgressHUD showError:@"获取验证码失败！"];
        }
    }];
    
    callBack(YES);
}

#pragma mark - 获取手机号码和验证码
-(NSString*)getTelephoneString{
    return self.telephoneTextField.text;
}

-(NSString*)getVerifyCode{
    return self.verifyTextField.text;
}

-(void)clearTextField{
    self.telephoneTextField.text = @"";
    self.verifyTextField.text = @"";
}
@end
