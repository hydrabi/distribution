//
//  PersonalViewControllerDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/1.
//  Copyright © 2016年 distribution. All rights reserved.
//

#define AreaState @"state"
#define AreaCity @"city"
#define AreaDistricts @"districts"

@protocol PersonalViewControllerDelegate <NSObject>

@optional

/**
 *  用户信息已修改并保存，需要刷新数据
 */
-(void)userPropertySave;

@end