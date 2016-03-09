//
//  AreaObject.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaObject : NSObject

//区域
@property (copy, nonatomic) NSString *region;
//省名
@property (copy, nonatomic) NSString *province;
//城市名
@property (copy, nonatomic) NSString *city;
//区县名
@property (copy, nonatomic) NSString *area;

@end
