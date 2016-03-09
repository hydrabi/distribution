//
//  SharePopSelectViewDelegate.h
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

//typedef NS_ENUM(NSInteger, SharePopSelectTableViewCellType){
//    SharePopSelectTableViewCellType_coat = 0,       /**<大衣*/
//    SharePopSelectTableViewCellType_pants,          /**<裤子*/
//    SharePopSelectTableViewCellType_dress,          /**<连衣裙*/
//    SharePopSelectTableViewCellType_sweater,        /**<毛衣*/
//};

#import "RequestData.h"

@protocol SharePopSelectViewDelegate <NSObject>

@optional
/**
 *  通知委托点击了的cell的类型
 *
 *  @param cellType SharePopSelectTableViewCellType
 */
-(void)didSelectWithCellType:(productType)cellType;

-(void)didHideSharePopView;

-(void)didShowSharePopView;

@end