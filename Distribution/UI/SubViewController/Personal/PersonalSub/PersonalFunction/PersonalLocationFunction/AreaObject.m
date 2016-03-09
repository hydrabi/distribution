//
//  AreaObject.m
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//
#import "AreaObject.h"

@implementation AreaObject

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.region,self.province,self.city,self.area];
}

@end
