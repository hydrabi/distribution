//
//  SearchProductViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "SearchProductViewController.h"
//#import "SearchProductDataSource.h"
//#import "SearchProductDataSourceDelegate.h"
#import "UIColor+Addition.h"
#import "CommodityDetailsViewController.h"
#import "AppDelegate.h"
#import "NSArray+Addition.h"

@interface SearchProductViewController ()
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSArray *dataArr;
//@property (strong,nonatomic)SearchProductDataSource *dataSource;
@end

@implementation SearchProductViewController

-(instancetype)initWithDataArr:(NSArray*)dataArr{
    self = [super init];
    if(self){
        self.dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configDataSoucre];
    [self configUI];
    [self navigationItemConfig];
    self.dataSource.dataTypeArr = self.dataArr.mutableCopy;
    [self.dataSource reloadTableViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
}

#pragma mark - configUI
-(void)configUI{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout                       = UIRectEdgeNone;///选择UIRectedgenone，视图的内容不会延伸到navigationbar的后面，就是不会顶穿导航栏
        self.extendedLayoutIncludesOpaqueBars             = NO;///这个属性指定了当bar使用了不透明图片时，视图是否延伸到bar所在区域，默认为NO
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.title = Global_SearchNavigationTitleName;
}

-(void)navigationItemConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
}

@end
