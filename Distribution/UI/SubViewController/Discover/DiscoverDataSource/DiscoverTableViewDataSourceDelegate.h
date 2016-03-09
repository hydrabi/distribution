//
//  DiscoverTableViewDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

typedef NS_ENUM(NSInteger, DiscoverTableDataType) {
    DiscoverTableDataType_service,          /**<客服*/
    DiscoverTableDataType_notification,     /**<通知*/
    DiscoverTableDataType_newActivity,      /**<最新活动*/
};

/**
 *  用于回调发现控制器操作
 */
@protocol DiscoverTableViewDataSourceDelegate <NSObject>

@optional

/**
 *  通知委托点击了某个cell
 *
 *  @param type cell所属的PersonalTableDataType
 */
-(void)didSelectRowOfDiscoverDataType:(DiscoverTableDataType)type;

@end
