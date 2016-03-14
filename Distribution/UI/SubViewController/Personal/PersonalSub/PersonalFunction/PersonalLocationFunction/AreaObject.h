//
//  AreaObject.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaObject : NSObject

//区域或省
@property (copy, nonatomic) NSString *state;
//城市名
@property (copy, nonatomic) NSString *city;
//区县或者城市
@property (copy, nonatomic) NSString *district;

@end
