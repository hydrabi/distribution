//
//  CommodityDetailsDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

typedef NS_ENUM(NSInteger,CommodityDetailsCellType) {
    CommodityDetailsCellType_Main,
    CommodityDetailsCellType_Introduce,
    CommodityDetailsCellType_Image,
};

@protocol CommodityDetailsDataSourceDelegate <NSObject>

@optional

-(void)imageClickWithArr:(NSMutableArray*)imageArr clickedIndex:(NSInteger)index;

@end
