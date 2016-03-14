//
//  PersonalContactTelephoneViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalTextFieldInputViewController.h"
#import "UIColor+Addition.h"
#import "PersonalMacro.h"

#import "AppDelegate.h"
#import "NSArray+Addition.h"

static NSString *personalContactTelephoneCellIndentifier = @"personalContactTelephoneCellIndentifier";

@interface PersonalTextFieldInputViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UITextField *cellTextField;
@property (assign,nonatomic) PersonalViewTextFieldInputType type;
@end

@implementation PersonalTextFieldInputViewController

-(instancetype)initWithPersonalViewTextFieldInputType:(PersonalViewTextFieldInputType)type{
    self = [super init];
    if(self){
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self navigationItemConfig];
    [self registerCellNib];
    [self inputTypeConfig];
}

#pragma mark - UI

-(void)inputTypeConfig{
    switch (self.type) {
        case PersonalViewTextFieldInputType_telephone:
        {
            self.title = @"联系电话";
        }
            break;
        case PersonalViewTextFieldInputType_weixin:
        {
            self.title = @"微信";
        }
            break;
        case PersonalViewTextFieldInputType_qq:
        {
            self.title = @"QQ";
        }
            break;
            
        default:
            break;
    }
}

-(void)UIConfig{
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = PersonalTableViewBackgroundColor;
}

-(void)navigationItemConfig{
    NSArray *left = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    UIBarButtonItem *right                 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
    self.navigationItem.rightBarButtonItem = right;
    
}

#pragma mark - 点击事件

-(void)returnButtonClick{
    [self.cellTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveButtonClick{
    AVUser *user = [AVUser currentUser];
    if(user){
        if (![self.cellTextField.text isEqualToString:user.contactTelephone]) {
            [self saveAVUserPorperty];
            if(self.delegate && [self.delegate respondsToSelector:@selector(userPropertySave)]){
                [self.delegate userPropertySave];
            }
        }
    }
    [self returnButtonClick];
}

-(void)saveAVUserPorperty{
    AVUser *user = [AVUser currentUser];
    switch (self.type) {
        case PersonalViewTextFieldInputType_telephone:
        {
            if(![self.cellTextField.text isEqualToString:user.contactTelephone]){
                user.contactTelephone = self.cellTextField.text;
            }
        }
            break;
        case PersonalViewTextFieldInputType_weixin:
        {
            if(![self.cellTextField.text isEqualToString:user.weixin]){
                user.weixin = self.cellTextField.text;
            }
        }
            break;
        case PersonalViewTextFieldInputType_qq:
        {
            if(![self.cellTextField.text isEqualToString:user.qq]){
                user.qq = self.cellTextField.text;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalContactTelephoneTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:personalContactTelephoneCellIndentifier];
    
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
    
    PersonalContactTelephoneTableViewCell *contactTelephoneCell = [self.tableView dequeueReusableCellWithIdentifier:personalContactTelephoneCellIndentifier forIndexPath:indexPath];
    cell = (UITableViewCell*)contactTelephoneCell;
    self.cellTextField = contactTelephoneCell.textField;
    [contactTelephoneCell resetValueWithType:self.type];
    [self.cellTextField becomeFirstResponder];
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

@end
