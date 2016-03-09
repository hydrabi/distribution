//
//  PersonalMainOrderCellButton.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

/**定制按钮类型*/
typedef NS_ENUM(NSInteger,PersonalMainOrderCellButtonType) {
    PersonalMainOrderCellButtonType_notPay,                    /**<代付款*/
    PersonalMainOrderCellButtonType_notDeliver,                /**<代发货*/
    PersonalMainOrderCellButtonType_hadDeliver,                /**<已发货*/
    PersonalMainOrderCellButtonType_Return                     /**<退货/退款*/
};

@interface PersonalMainOrderCellButton : UIButton

-(instancetype)initWithButtonType:(PersonalMainOrderCellButtonType)type;

@end
