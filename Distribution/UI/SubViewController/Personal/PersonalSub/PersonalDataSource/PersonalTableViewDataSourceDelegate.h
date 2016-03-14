//
//  PersonalTableViewDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PersonalMacro.h"
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
