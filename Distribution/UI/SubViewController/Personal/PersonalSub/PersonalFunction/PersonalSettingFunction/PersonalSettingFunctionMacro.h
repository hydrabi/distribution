//
//  PersonalSettingFunctionMacro.h
//  Distribution
//
//  Created by Hydra on 16/3/9.
//  Copyright © 2016年 distribution. All rights reserved.
//

#ifndef PersonalSettingFunctionMacro_h
#define PersonalSettingFunctionMacro_h

typedef NS_ENUM(NSInteger,PersonalSettingType) {
    PersonalSettingTypeWifiShowImage,       /**在wifi下显示图片<*/
    PersonalSettingTypeClearCache,          /**缓存清理*/
    PersonalSettingTypeEvaluate,            /**给我评价*/
    PersonalSettingTypeAboutUs              /**关于我们*/
};

#define PersonalSettingFunctionTableViewBackgroundColor [UIColor colorWithHexString:@"eeeeee" alpha:1]
#define UserDefaultKey_PersonalSettingFunctionSetingWifiShowImage @"UserDefaultKey_PersonalSettingFunctionSetingWifiShowImage"


#endif /* PersonalSettingFunctionMacro_h */
