//
//  RequestLocation.h
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestLocation : NSObject
@property (nonatomic,strong) NSString *location;
+(instancetype)shareInstance;
- (void)openGPSWithHUD:(BOOL)HUD;
@end
