//
//  PersonalTableViewDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

typedef NS_ENUM(NSInteger, PersonalTableDataType) {
    PersonalTableDataType_head,
    PersonalTableDataType_age,
    PersonalTableDataType_gender,
    PersonalTableDataType_location,
    PersonalTableDataType_telephone,
    PersonalTableDataType_nickname,
    PersonalTableDataType_signature,
};

/**
 *  用于回调个人控制器操作
 */
@protocol PersonalTableViewDataSourceDelegate <NSObject>

@optional

/**
 *  通知委托点击了某个cell
 *
 *  @param type cell所属的PersonalTableDataType
 */
-(void)didSelectRowOfAboutDataType:(PersonalTableDataType)type;

@end
