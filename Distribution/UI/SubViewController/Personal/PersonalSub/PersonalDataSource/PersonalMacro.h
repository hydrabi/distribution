//
//  PersonalMacro.h
//  Distribution
//
//  Created by Hydra on 15/12/31.
//  Copyright © 2015年 distribution. All rights reserved.
//

#ifndef PersonalMacro_h
#define PersonalMacro_h

#pragma mark - PersonalTableView

typedef NS_ENUM(NSInteger, PersonalTableDataType) {
    PersonalTableDataType_head,
    PersonalTableDataType_age,
    PersonalTableDataType_gender,
    PersonalTableDataType_location,
    PersonalTableDataType_telephone,
    PersonalTableDataType_nickname,
    PersonalTableDataType_weixin,
    PersonalTableDataType_qq,
    PersonalTableDataType_manageAdress,
    PersonalTableDataType_modifyPassword,
};

#define PersonalTableViewBackgroundColor [UIColor colorWithHexString:@"eeeeee" alpha:1]
#define PersonalTableViewSectionHeaderHeight 10.0f
#define PersonalTableViewCellLeftSeparatorInset 12.0f
#define Notification_LoginStatusChange @"Notification_LoginStatusChange"
#define Notification_PersonalInfoChange @"Notification_PersonalInfoChange"  //用户信息改变
#define Notification_LocationChange @"Notification_LocationChange"          //位置改变
#pragma mark - PersonalTableViewCell

#define PersonalNormalCellHeight 44.0f
#define PersonalHeadCellHeight 74.0f
#define PersonalHeadCellImageHeight 60.0f

#pragma mark - PersonalTableViewFooter

#define PersonalTableViewFooterHeight 70.0f

#endif /* PersonalMacro_h */
