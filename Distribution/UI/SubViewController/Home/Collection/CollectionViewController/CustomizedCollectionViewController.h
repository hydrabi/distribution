//
//  CustomizedViewController.h
//  Distribution
//
//  Created by Hydra on 15/12/17.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomizedCollectionViewControllerDelegate.h"
#import "SharePopSelectViewDelegate.h"
#import "RequestData.h"
typedef void (^testBlock) (NSInteger index);
@interface CustomizedCollectionViewController : UIViewController

@property (nonatomic,weak) id<CustomizedCollectionViewControllerDelegate> homeDelegate;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,copy)testBlock test;
@property (nonatomic,assign)productType pdType;
/**
 *  初次刷新
 */
-(void)refreshIfShould;
/**
 *  强制刷新
 */
-(void)forceRefresh;
@end
