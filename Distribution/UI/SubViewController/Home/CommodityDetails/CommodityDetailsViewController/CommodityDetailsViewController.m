//
//  CommodityDetailsViewController.m
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CommodityDetailsViewController.h"
#import "CommodityDetailsDataSource.h"
#import "AppDelegate.h"
#import "CommodityDetailsMacro.h"
#import "CommodityDetailsDataSourceDelegate.h"
#import "UIColor+Addition.h"
#import "CustomMWPhotoBrowser.h"
#import "RequestData.h"
#import "NSArray+Addition.h"
#import "CustomShare.h"

@interface CommodityDetailsViewController ()<CommodityDetailsDataSourceDelegate,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *photos;
/**
 *  数据源
 */
@property (strong,nonatomic) CommodityDetailsDataSource *dataSource;
/**
 *  查询任务
 */
@property (strong,nonatomic) NSURLSessionDataTask *task;
/**
 *  弹出的正在刷新提示
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;
/**
 *  商品
 */
@property (strong,nonatomic) AVObject *object;
@end

@implementation CommodityDetailsViewController

-(instancetype)initWithObject:(AVObject *)object{
    self = [super init];
    if(self){
        self.object = object;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTrack];
    [self configUI];
    [self progressHUDConfig];
    [self configDataSoucre];
    [self navigationItemConfig];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    NSLog(@"CommodityDetailsViewController商品详情资源已被释放");
}

#pragma mark - configTrace
//添加足迹
-(void)configTrack{
    AVUser *user = [AVUser currentUser];
    if(user){
        [user addTraceWithObject:self.object];
    }
}

#pragma mark - configUI
-(void)configUI{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout                       = UIRectEdgeNone;///选择UIRectedgenone，视图的内容不会延伸到navigationbar的后面，就是不会顶穿导航栏
        self.extendedLayoutIncludesOpaqueBars             = NO;///这个属性指定了当bar使用了不透明图片时，视图是否延伸到bar所在区域，默认为NO
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.title = @"商品详情";
    self.tableView.backgroundColor = CommodityDetailsTableViewBackgroundColor;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self purchaseButtonUIConfig];
}

-(void)purchaseButtonUIConfig{
    [self.purchaseButton setTitle:@"点击购买" forState:UIControlStateNormal];
    [self.purchaseButton setBackgroundColor:[UIColor colorWithHexString:@"ff4400" alpha:1]];
    [self.purchaseButton addTarget:self action:@selector(purchaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)progressHUDConfig{
    //圆形进度条
    self.progressHUD          = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    self.progressHUD.mode     = MBProgressHUDModeIndeterminate;
}

#pragma mark - 点击事件
//购买
-(void)purchaseButtonClick:(UIButton*)button{
    
}
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
    
}
//分享
-(void)shareButtonClick{
    [[CustomShare shareManager] showShareMenuWithObject:self.object];
}

#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[CommodityDetailsDataSource alloc] initWithTableView:self.tableView object:self.object];
    self.dataSource.delegate = self;
}

-(void)navigationItemConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(shareButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark - CommodityDetailsDataSourceDelegate
-(void)imageClickWithArr:(NSMutableArray*)imageArr clickedIndex:(NSInteger)index{
    MWPhoto *photo;
    NSMutableArray *photos = @[].mutableCopy;
    for(NSInteger i = 0;i<imageArr.count;i++){
        NSString *imageName = imageArr[i];
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:imageName]];
        //图片描述
        photo.caption = @"";
        [photos addObject:photo];
    }
    
    self.photos = photos;
    // Create browser
    CustomMWPhotoBrowser *browser = [[CustomMWPhotoBrowser alloc] initWithDelegate:self];
    //右上角按钮
    browser.displayActionButton = YES;
    //底部页面切换toolBar
    browser.displayNavArrows = NO;
    //选择按钮
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = NO;
    [browser setCurrentPhotoIndex:index];
    [self.navigationController pushViewController:browser animated:YES];
    
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

@end
