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
#import "AccountNavigationManager.h"

@interface CustomRegisterFirstStepViewController ()
@property (nonatomic,weak)UITextField *telephoneTextField;
@property (nonatomic,weak)UITextField *verifyTextField;
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
        
    }];
}

-(void)configDataTypeArr{
    [super configDataTypeArr];
    self.dataTypeArr = @[@(AccountReleateCellType_registerTelephone),
                         @(AccountReleateCellType_registerVerifyButton)].mutableCopy;
}

-(void)mainButtonClick{
    [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_RegisterSecond];
}

-(void)subButtonClick{
    
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
            cell = (UITableViewCell*)verifyCell;
        }
            break;
        
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
