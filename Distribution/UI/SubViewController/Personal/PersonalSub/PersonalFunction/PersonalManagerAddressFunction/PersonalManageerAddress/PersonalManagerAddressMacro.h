//
//  PersonalManagerAddressMacro.h
//  Distribution
//
//  Created by Hydra on 16/3/12.
//  Copyright © 2016年 distribution. All rights reserved.
//

#ifndef PersonalManagerAddressMacro_h
#define PersonalManagerAddressMacro_h


#define PersonalAddrestListFooterTitleColor [UIColor colorWithHexString:@"747474" alpha:1]
#define PersonalAddrestListCellTitleColor [UIColor colorWithHexString:@"747474" alpha:1]
#define PersonalAddrestListFooterTitle @"添加收货地址"
#define PersonalAddrestListFooterTitleFont [UIFont systemFontOfSize:16.0f]
#define PersonalAddrestListFooterPlusImageWidthAndHeight 15.0f
#define PersonalAddrestListFooterHeight 100.0f
#define PersonalAddrestListCellHeight 100.0f


typedef NS_ENUM(NSInteger,PersonalAddressDetailCellType) {
    PersonalAddressDetailCellType_consignee,        //收货人
    PersonalAddressDetailCellType_telephone,        //手机号码
    PersonalAddressDetailCellType_area,             //所在地区
    PersonalAddressDetailCellType_detailAddress,    //详细地址
    PersonalAddressDetailCellType_delete,           //删除地址
};

#define PersonalAddrestDetailCellValueColor [UIColor colorWithHexString:@"3f3f3f" alpha:1]
#define PersonalAddrestDetailCellTitleColor [UIColor colorWithHexString:@"747474" alpha:1]
#define PersonalAddrestDetailTitleFont [UIFont systemFontOfSize:16.0f]
#define PersonalAddrestDetailCellHeight 44.0f
#define PersonalAddressDetailDefaultButtonBackgroundColor [UIColor colorWithHexString:@"ff4400" alpha:1]
#define PersonalAddressDetailDefaultButtonTitleColor [UIColor whiteColor]
#define PersonalAddressDetailDefaultButtonTitle @"设为默认收货地址"
#define PersonalAddressDetailDefaultButtonHeight 50.0f

typedef NS_ENUM(NSInteger,PersonalManagerAddressType) {
    PersonalManagerAddressType_new,             //新建收货地址
    PersonalManagerAddressType_modify           //修改已有收货地址
};

typedef NS_ENUM(NSInteger,CustomInputTextFieldCellType) {
    CustomInputTextFieldCell_consignee,             //收货人
    CustomInputTextFieldCell_telephone              //手机号码
};

#define PersonalManagerAddrestTitleFont [UIFont systemFontOfSize:16.0f]
#define PersonalManagerAddrestSaveButtonBackgroundColor [UIColor colorWithHexString:@"ff4400" alpha:1]
#define PersonalManagerAddrestSaveButtonTitleColor [UIColor whiteColor]
#define PersonalManagerAddrestSaveButtonTitle @"保存"
#define PersonalManagerAddrestSaveButtonFont [UIFont systemFontOfSize:18.0f]
#define PersonalManagerAddrestSaveButtonHeight 50.0f
#define PersonalManagerAddrestPickerHeight 166.0f;
#define PersonalManagerAddrestConsigneeMaxLength 15
#define PersonalManagerAddrestDetailMaxLength 60
#define PersonalManagerAddrestTextViewCellHeight 80.0f
#define PersonalManagerAddrestNomalCellDefaultTitle @"省，市，区"
#endif /* PersonalManagerAddressMacro_h */
