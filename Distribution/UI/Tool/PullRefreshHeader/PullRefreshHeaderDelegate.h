//
//  PullRefreshHeaderDelegate.h
//  pullRefreshSample
//
//  Created by 毕志锋 on 15/11/13.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

typedef NS_ENUM(NSInteger,refreshStatus) {
    refreshStatus_spaceDeficiency,      /**<仍需要一定的距离才能刷新*/
    refreshStatus_spaceEnough,          /**<可以松手刷新*/
    refreshStatus_loading,               /**<正在刷新中*/
    
};

#import <UIKit/UIKit.h>
@protocol PullRefreshHeaderDelegate <NSObject>

@required
-(void)shouldRefreshNow;
@end
