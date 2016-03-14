//
//  PersonalMainTableViewDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainMacro.h"

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
