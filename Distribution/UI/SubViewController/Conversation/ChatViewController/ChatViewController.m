//
//  ChatViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/8.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
#import "PersonalMacro.h"
#import "NSArray+Addition.h"
@interface ChatViewController ()<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>
@property (nonatomic,strong)UIMenuItem *cpMenuItem;
@property (nonatomic,strong)UIMenuItem *deleteMenuItem;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    [self UIConfig];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
}

#pragma mark - action
/**登录状态改变*/
-(void)loginStatusChange{
    if(![[PersonlInfoManager shareManager] hadLogin]){
        [self returnButtonClick];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
-(void)UIConfig{
    [self cellAppearanceConfig];
    [self navigationItemConfig];
//    [self updateMoreViewImage];
}

//设置cell外观
-(void)cellAppearanceConfig{
    
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_bg"] stretchableImageWithLeftCapWidth:35 topCapHeight:35]];
    
    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
    
    //通过会话管理者获取已收发消息
    [self tableViewDidTriggerHeaderRefresh];
    
    EaseEmotionManager *manager= [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:[EaseEmoji allEmoji]];
    [self.faceView setEmotionManagers:@[manager]];
}

-(void)navigationItemConfig{
    NSArray *left = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    UIBarButtonItem *right                 = [[UIBarButtonItem alloc] initWithTitle:@"清除记录" style:UIBarButtonItemStyleBordered target:self action:@selector(clearButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
    self.navigationItem.rightBarButtonItem = right;
}

//-(void)updateMoreViewImage{
//    [self.chatBarMoreView updateItemWithImage:[UIImage imageNamed:@"chatBarMoreView_photo"] highlightedImage:[UIImage imageNamed:@"chatBarMoreView_photo"] title:@"图片" atIndex:0];
//}

#pragma mark - 点击事件

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
}

-(void)clearButtonClick{
    if (self.dataArray.count == 0) {
        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        self.messageTimeIntervalTag = -1;
        [self.conversation removeAllMessages];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
    }
}

#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self _showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}

//- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
//                           modelForMessage:(EMMessage *)message
//{
//    //用户可以根据自己的用户体系,根据message设置用户昵称和头像
//    id<IMessageModel> model = nil;
//    model = [[EaseMessageModel alloc] initWithMessage:message];
//    model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];//默认头像
//    model.avatarURLPath = @"";//头像网络地址
//    model.nickname = @"昵称";//用户昵称
//    return model;
//}

#pragma mark - private

- (void)_showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(MessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuAction:)];
    }
    
    if (_cpMenuItem == nil) {
        _cpMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMenuAction:)];
    }
    
    
    
    if (messageType == eMessageBodyType_Text) {
        [self.menuController setMenuItems:@[_cpMenuItem, _deleteMenuItem]];
    } else if (messageType == eMessageBodyType_Image){
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}

#pragma mark - action
- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation removeMessage:model.message];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    self.menuIndexPath = nil;
}

@end
