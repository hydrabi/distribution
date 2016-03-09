//
//  NSArray+Addition.m
//  Distribution
//
//  Created by Hydra on 16/1/26.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray(Addition)

+(NSArray*)navigationItemsWithImageName:(NSString *)imageName target:(id)target selecter:(SEL)selecter{
    //按钮
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:target action:selecter forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    //空白
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = -10;
    
    NSArray *itemsArr = @[searchItem,space];
    return itemsArr;
}

+(NSArray*)navigationItemsReturnWithTarget:(id)target selecter:(SEL)selector{
    return [NSArray navigationItemsWithImageName:@"navigation_back" target:target selecter:selector];
}

@end
