//
//  CustomBaseProductListViewController.h
//  Distribution
//
//  Created by Hydra on 16/3/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBaseProductListDataSource.h"
#import "CustomBaseProductListDataSourceDelegate.h"
@interface CustomBaseProductListViewController : UIViewController<CustomBaseProductListDataSourceDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) CustomBaseProductListDataSource *dataSource;

-(void)configUI;
-(void)configDataSoucre;
@end
