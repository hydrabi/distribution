//
//  ConversationListViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/8.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ConversationListViewController.h"
#import "AppDelegate.h"
#import "CustomControllerTitleView.h"
#import "ConversationMacro.h"
#import "UIColor+Addition.h"
#import "ChatViewController.h"
#import "PersonalMacro.h"
#import "NSArray+Addition.h"
@interface ConversationListViewController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>

@end

@implementation ConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    [self tableViewDidTriggerHeaderRefresh];
    [self addServiceConversation];
    [self configUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
    
    //注册失败重连机制
    [[PersonlInfoManager shareManager] easeReloginIfLoginFail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
/**登录状态改变*/
-(void)loginStatusChange{
    [self addServiceConversation];
    [self tableViewDidTriggerHeaderRefresh];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - configUI
-(void)configUI{
    self.tableView.backgroundColor = ConversationTableViewBackgroundColor;
    self.title = Global_ServiceNavigationTitleName;
    [self navigationItemConfig];
}

-(void)navigationItemConfig{
    NSArray *left = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
}

-(void)addServiceConversation{
    if(self.dataArray.count == 0 && [[EaseMob sharedInstance].chatManager isLoggedIn]){
        EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"15820102011" conversationType:eConversationTypeChat];
        EaseConversationModel *conversationModel = [[EaseConversationModel alloc] initWithConversation:conversation];
        [self.dataArray addObject:conversationModel];
        [self tableViewDidFinishTriggerHeader:YES reload:YES];
    }
}

#pragma mark - 点击事件
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
}

#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
            
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
            chatController.title = conversationModel.title;
            [self.navigationController pushViewController:chatController animated:YES];
            [[AppDelegate getRootController] hideTabbar];
        }
    }
}

#pragma mark - EaseConversationListViewControllerDataSource
- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.conversationType == eConversationTypeChat) {
//        if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.chatter]) {
//            model.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.chatter];
//        } else {
//            UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:conversation.chatter];
//            if (profileEntity) {
//                model.title = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
//                model.avatarURLPath = profileEntity.imageUrl;
//            }
//        }
    } else if (model.conversation.conversationType == eConversationTypeGroupChat) {
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"groupSubject"] || ![conversation.ext objectForKey:@"isPublic"])
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    model.title = group.groupSubject;
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    model.avatarImage = [UIImage imageNamed:imageName];
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        } else {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    NSString *groupSubject = [ext objectForKey:@"groupSubject"];
                    NSString *conversationSubject = [conversation.ext objectForKey:@"groupSubject"];
                    if (groupSubject && conversationSubject && ![groupSubject isEqualToString:conversationSubject]) {
                        conversation.ext = ext;
                    }
                    break;
                }
            }
            model.title = [conversation.ext objectForKey:@"groupSubject"];
            imageName = [[conversation.ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
            model.avatarImage = [UIImage imageNamed:imageName];
        }
    }
    return model;
}

@end
