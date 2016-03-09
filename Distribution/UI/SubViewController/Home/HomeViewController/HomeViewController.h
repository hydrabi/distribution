//
//  HomeViewController.h
//  Distribution
//
//  Created by Hydra on 15/12/16.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestData.h"

@interface HomeViewController : UIViewController
/**
 *  搜索取消第一响应
 */
-(void)resignSerchBarFirstResponse;
/**
 *  通知主视图已经跳转到某个子视图
 *
 *  @param index 子视图的索引
 */
-(void)hadScrollToViewWithIndex:(NSInteger)index;
/**
 *  通知主视图选择了弹出的某一个商品类型
 *
 *  @param type 商品类型
 */
-(void)hadSelectSharePopSelectTableViewCellType:(productType)type;

-(void)showClassifyView;
@end
