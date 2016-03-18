//
//  PersonalFeedBackFunctionViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalFeedBackFunctionViewController.h"
#import "PlaceHolderTextView.h"
#import "UIColor+Addition.h"
#import "NSArray+Addition.h"
#import "CustomInputTextViewTableViewCell.h"
#import "BaseAccountReleateTableViewFooter.h"
#import "LoginRegisterAndPasswordMacro.h"

#define maxAdviceNumber 80
#define textViewHeight 120.0f
static NSString *customInputTextViewTableViewCellIndentifier = @"customInputTextViewTableViewCellIndentifier";

@interface PersonalFeedBackFunctionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,weak)PlaceHolderTextView *adviceTextView;
@property (nonatomic,strong)BaseAccountReleateTableViewFooter *footerView;
@end

@implementation PersonalFeedBackFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self navigitionConfig];
    [self registerCellNib];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configUI
-(void)UIConfig{
    self.title                         = @"意见反馈";
    self.tableView.backgroundColor     = Global_TableViewBackgroundColor;
    self.view.backgroundColor          = Global_TableViewBackgroundColor;
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.footerView = [[BaseAccountReleateTableViewFooter alloc] initWithType:AccountReleateViewControllerType_adviceFeedBack frame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), BaseAccountTableViewFooterHeight)];
    self.tableView.tableFooterView = self.footerView;
    [self.footerView.mainButton addTarget:self action:@selector(mainButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewTextViewCellNib = [UINib nibWithNibName:NSStringFromClass([CustomInputTextViewTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewTextViewCellNib forCellReuseIdentifier:customInputTextViewTableViewCellIndentifier];
}

#pragma mark - 点击事件
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)mainButtonClick{
    if(self.adviceTextView.text.length == 0){
        [MBProgressHUD showError:@"意见反馈内容不能为空！"];
        return;
    }
    
    if(self.adviceTextView.text.length>maxAdviceNumber){
        [MBProgressHUD showError:[NSString stringWithFormat:@"意见反馈内容不能超过%d个字！",maxAdviceNumber]];
        return;
    }
    
    AVUser *user = [AVUser currentUser];
    if(user){
        [user addAdviceWithStr:self.adviceTextView.text];
        [self returnButtonClick];
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
    return textViewHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.1;
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomInputTextViewTableViewCell *textViewCell = [self.tableView dequeueReusableCellWithIdentifier:customInputTextViewTableViewCellIndentifier forIndexPath:indexPath];
    self.adviceTextView = textViewCell.textView;
    [textViewCell resetAdviceFeedbackPlaceholder];
    [textViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return textViewCell;
}

@end
