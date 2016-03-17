//
//  CustomLoginViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomLoginViewController.h"
#import "CustomPrefixInputTextFieldTableViewCell.h"
#import "AccountNavigationManager.h"
@interface CustomLoginViewController ()
@property (nonatomic,weak)UITextField *accountTextField;
@property (nonatomic,weak)UITextField *passwordTextField;
@end

@implementation CustomLoginViewController

+(instancetype)shareInstance{
    static CustomLoginViewController *login = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[CustomLoginViewController alloc] initWithType:AccountReleateViewControllerType_Login];
    });
    return login;
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
    self.title = @"登录";
}

-(void)navigitionConfig{
    [super navigitionConfig];
    UIBarButtonItem *registerButtonClick = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleBordered target:self action:@selector(registerButtonClick)];
    self.navigationItem.rightBarButtonItem = registerButtonClick;
}

-(void)registerButtonClick{
    [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_RegisterFirst];
}

-(void)returnButtonClick{
    [super returnButtonClick];
    [[AccountNavigationManager shareInstance] hideNavWithCompletion:^{
        
    }];
}

-(void)configDataTypeArr{
    [super configDataTypeArr];
    self.dataTypeArr = @[@(AccountReleateCellType_loginAccount),
                         @(AccountReleateCellType_loginPassword)].mutableCopy;
}

-(void)mainButtonClick{
    
}

-(void)subButtonClick{
    [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_forgetPassword];
}



#pragma mark - tableviewDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    AccountReleateCellType type = [self getSpecificTypeWithIndexPath:indexPath];
    switch (type) {
        case AccountReleateCellType_loginAccount:
        {
            CustomPrefixInputTextFieldTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:customPrefixInputTextFieldTableViewCellReuseIdentifier forIndexPath:indexPath];
            self.accountTextField = accountCell.textField;
            [accountCell setType:type];
            cell = (UITableViewCell*)accountCell;
        }
             break;
        case AccountReleateCellType_loginPassword:
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
