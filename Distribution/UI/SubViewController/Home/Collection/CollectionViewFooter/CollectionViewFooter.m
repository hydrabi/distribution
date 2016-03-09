//
//  CollectionViewFooter.m
//  Distribution
//
//  Created by Hydra on 15/12/18.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "CollectionViewFooter.h"
#import "UIColor+Addition.h"
@implementation CollectionViewFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    }
    return self;
}

@end
