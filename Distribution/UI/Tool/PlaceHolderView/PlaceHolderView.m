//
//  PlaceHolderView.m
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PlaceHolderView.h"

@implementation PlaceHolderView

/**从coder初始化*/
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder{
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *xibName = [self xibName];
    
    
    NSArray *viewArray;
    viewArray = [mainBundle loadNibNamed:xibName      owner:nil options:nil];
    
    UIView *view =[viewArray firstObject];      //从xib加载view
    view.translatesAutoresizingMaskIntoConstraints = NO;                                                            //禁止将view的边距转换为约束
    if ([view conformsToProtocol:@protocol(PlaceHolderInitDelegate)]) {
        //如果实现了PlaceHolderInitDelegate,调用commonInitCallByPlaceHolderView方法
        if([view respondsToSelector:@selector(commonInitCallByPlaceHolderView)]){
            [(id<PlaceHolderInitDelegate>)view commonInitCallByPlaceHolderView];
        }else{
            NSLog(@"Warning , commonInitCallByPlaceHolderView is not responds for view %@",view);
        }
    }
    return view;            //使用新的view替换本来的view
}

- (NSString *)xibName{
    return nil;
}

@end
