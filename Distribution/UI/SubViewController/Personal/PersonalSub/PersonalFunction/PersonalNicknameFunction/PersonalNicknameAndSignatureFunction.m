//
//  PersonalNicknameAndSignatureFunction.m
//  Distribution
//
//  Created by Hydra on 16/1/29.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalNicknameAndSignatureFunction.h"
#import "PersonalMacro.h"
#import "UIColor+Addition.h"
#import "NSArray+Addition.h"
#import "AppDelegate.h"
#import "PersonalNicknameAndSignatureTableViewCell.h"

static NSString *personalNicknameAndSignatureCellIndentifier = @"personalNicknameAndSignatureCellIndentifier";

@interface PersonalNicknameAndSignatureFunction ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UITextField *cellTextField;
@property (assign,nonatomic)PersonalInputAttributeType type;
@end

@implementation PersonalNicknameAndSignatureFunction

-(instancetype)initWithType:(PersonalInputAttributeType)type{
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
}


#pragma mark - UI

-(void)UIConfig{
    [self titleConfig];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = PersonalTableViewBackgroundColor;
}

-(void)titleConfig{
    switch (self.type) {
        case PersonalInputAttributeType_nickname:
            self.title = @"修改昵称";
            break;
        case PersonalInputAttributeType_signature:
            self.title = @"修改个人签名";
            break;
        default:
            break;
    }
}

-(void)navigationItemConfig{
    NSArray *left = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    UIBarButtonItem *right                 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)returnButtonClick{
    [self.cellTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveButtonClick{
    //如果长度验证失败，无法保存并提示
    if(![self verifyTextLength]){
        return;
    }
    
    AVUser *user = [AVUser currentUser];

    BOOL saveSuccess = NO;
    if(user){
        if(self.type == PersonalInputAttributeType_nickname){
            if (![self.cellTextField.text isEqualToString:user.nickname]) {
                user.nickname = self.cellTextField.text;
                saveSuccess = YES;
            }
        }
        else if (self.type == PersonalInputAttributeType_signature){
            if (![self.cellTextField.text isEqualToString:user.signature]) {
                user.signature = self.cellTextField.text;
                saveSuccess = YES;
            }
        }
        
        if(saveSuccess){
            [user saveEventually];
            if(self.delegate && [self.delegate respondsToSelector:@selector(userPropertySave)]){
                [self.delegate userPropertySave];
            }
        }
    }
    [self returnButtonClick];
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
    UINib *tableViewCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalNicknameAndSignatureTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:personalNicknameAndSignatureCellIndentifier];
    
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
    
    PersonalNicknameAndSignatureTableViewCell *personalCell = [self.tableView dequeueReusableCellWithIdentifier:personalNicknameAndSignatureCellIndentifier forIndexPath:indexPath];
    personalCell.type = self.type;
    cell = (UITableViewCell*)personalCell;
    if(!self.cellTextField){
        self.cellTextField = personalCell.textFileld;
//        [self.cellTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
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

#pragma mark - textField输入改变
- (void)textFieldEditChanged:(UITextField *)textField
{
//    NSInteger maxLength = 0;
//    if(self.type == PersonalInputAttributeType_nickname){
//        maxLength = maxNicknameLength;
//    }
//    else{
//        maxLength = maxSignatureLength;
//    }
//    NSString *text = textField.text;
//    if(text.length > maxLength){
//        
//        //输入超长,截断
//        textField.text = [text substringToIndex:maxLength];
//        [MBProgressHUD showError:@"输入长度超过限制！"];
//    }
}

-(BOOL)verifyTextLength{
    BOOL result = YES;
    NSInteger maxLength = 0;
    if(self.type == PersonalInputAttributeType_nickname){
        maxLength = maxNicknameLength;
        if(self.cellTextField.text.length>maxLength){
            result = NO;
        }
        
    }
    else{
        maxLength = maxSignatureLength;
        if(self.cellTextField.text.length>maxLength){
            result = NO;
        }
        maxLength = maxSignatureLength;
    }
    
    if(!result){
        [MBProgressHUD showError:@"输入长度超过限制！已去除超出的长度"];
        //输入超长,截断
        self.cellTextField.text = [self.cellTextField.text substringToIndex:maxLength];
    }
    
    return result;
}

@end
