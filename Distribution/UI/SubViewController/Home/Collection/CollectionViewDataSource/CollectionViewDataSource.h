//
//  CollectionViewDataSource.h
//  Distribution
//
//  Created by Hydra on 15/12/17.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHTCollectionViewWaterfallLayout.h"

@class CustomizedCollectionViewController;
@interface CollectionViewDataSource : NSObject<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

-(instancetype)initWithDelegate:(CustomizedCollectionViewController*)delegate;

/**
 *  刷新数据后重新配置页面数据源
 *
 *  @param data 查询成功后获得的数据
 */
-(void)resetDataSource:(NSMutableArray*)data;
@end
