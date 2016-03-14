//
//  PersonalMainMacro.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#ifndef PersonalMainMacro_h
#define PersonalMainMacro_h

typedef NS_ENUM(NSInteger, PersonalMainTableDataType) {
    PersonalMainTableDataType_name,         /**<名称签名等*/
    PersonalMainTableDataType_orderHeader,  /**<订单头部*/
    PersonalMainTableDataType_order,        /**<订单*/
    PersonalMainTableDataType_footprint,    /**<足迹*/
    PersonalMainTableDataType_location,     /**<位置*/
    PersonalMainTableDataType_telephone,    /**<电话*/
    PersonalMainTableDataType_recommend,    /**<推荐*/
    PersonalMainTableDataType_setting,      /**<设置*/
};

/**定制按钮类型*/
typedef NS_ENUM(NSInteger,PersonalMainOrderCellButtonType) {
    PersonalMainOrderCellButtonType_notPay,                    /**<代付款*/
    PersonalMainOrderCellButtonType_notDeliver,                /**<代发货*/
    PersonalMainOrderCellButtonType_hadDeliver,                /**<已发货*/
    PersonalMainOrderCellButtonType_hadFinish,                   /**<已完成*/
    PersonalMainOrderCellButtonType_Return,                    /**<退货/退款*/
    PersonalMainOrderCellButtonType_myPoint,                    /**<我的积分*/
    PersonalMainOrderCellButtonType_myWallet,                   /**<我的钱包*/
    PersonalMainOrderCellButtonType_myCollect                   /**<我的收藏*/
};

#pragma mark - PersonalMainTableView

#define PersonalMainTableViewBackgroundColor [UIColor colorWithHexString:@"eeeeee" alpha:1]

//PersonalTableViewHeader



//PersonalTableViewCell
#define PersonalMainNameTableViewCellHeight 190.0f
#define PersonalMainOrderTableViewCellHeight 65.0f
#define PersonalMainNormalTableViewCellHeight 44.0f
#define PersonalMainOrderHeaderTableViewHeight 30.0f

#define PersonalMainNameTableViewCell_HeadImageWidthAndHeight 80.0f

#endif /* PersonalMainMacro_h */
