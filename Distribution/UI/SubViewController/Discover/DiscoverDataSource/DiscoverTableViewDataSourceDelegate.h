//
//  DiscoverTableViewDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverlMacro.h"

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
