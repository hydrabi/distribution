//
//  PersonalMainTableViewDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

typedef NS_ENUM(NSInteger, PersonalMainTableDataType) {
    PersonalMainTableDataType_name,         /**<名称签名等*/
    PersonalMainTableDataType_orderHeader,  /**<订单头部*/
    PersonalMainTableDataType_order,        /**<订单*/
    PersonalMainTableDataType_footprint,    /**<足迹*/
    PersonalMainTableDataType_location,     /**<位置*/
    PersonalMainTableDataType_telephone,    /**<电话*/
    PersonalMainTableDataType_setting,      /**<设置*/
};

/**
 *  用于回调个人控制器操作
 */
@protocol PersonalMainTableViewDataSourceDelegate <NSObject>

@optional

/**
 *  通知委托点击了某个cell
 *
 *  @param type cell所属的PersonalTableDataType
 */
-(void)didSelectRowOfPersonalMainDataType:(PersonalMainTableDataType)type;

@end
