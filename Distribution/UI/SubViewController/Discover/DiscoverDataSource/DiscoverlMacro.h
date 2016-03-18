//
//  DiscoverlMacro.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#ifndef DiscoverlMacro_h
#define DiscoverlMacro_h

typedef NS_ENUM(NSInteger, DiscoverTableDataType) {
    DiscoverTableDataType_service,          /**<客服*/
    DiscoverTableDataType_notification,     /**<通知*/
    DiscoverTableDataType_newActivity,      /**<最新活动*/
};

typedef NS_ENUM(NSInteger,DiscoverSubDetailCellType) {
    DiscoverSubDetailCellType_title,
    DiscoverSubDetailCellType_image,
    DiscoverSubDetailCellType_introduce,
    DiscoverSubDetailCellType_time,
};

#define DiscoverTableViewBackgroundColor [UIColor colorWithHexString:@"eeeeee" alpha:1]
#define DiscoverTableViewSectionHeaderHeight 10.0f
#define DiscoverTableViewCellHeight 50.0f
#define DiscoverTableViewHeaderHeight 10.0f

#define DiscoverSubViewListTableViewCellHeight 70.0f

#define DiscoverSubDetailTitleTableViewCellHeight 95.0f
#define DiscoverSubDetailImageTableViewCellHeight 230.0f
#define DiscoverSubDetailTimeTableViewCellHeight 50.0f

#define DiscoverNormalCellHeight 44.0f

#endif /* DiscoverlMacro_h */
