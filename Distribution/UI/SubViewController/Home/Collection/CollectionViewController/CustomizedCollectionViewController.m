//
//  CustomizedViewController.m
//  Distribution
//
//  Created by Hydra on 15/12/17.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "CustomizedCollectionViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CustomizedCollectionMacro.h"
#import "CollectionViewDataSource.h"
#import "MJRefresh.h"
#import "NSArray+Addition.h"
#import "UIColor+Addition.h"
#import "CommodityDetailsViewController.h"
@interface CustomizedCollectionViewController ()

/**collectView的数据源*/
@property (nonatomic,strong)CollectionViewDataSource *collectDataSource;
/**当前翻到的页数*/
@property (nonatomic,assign)NSInteger flipPage;
/**所有商品总数目*/
@property (nonatomic,assign)NSInteger totalProductNum;
/**上拉需要请求的商品数目*/
@property (nonatomic,assign)NSInteger pullRequestProductNum;
/**数据源*/
@property (nonatomic,strong)NSMutableArray *dataSourceArrs;
/**上拉加载已加载完全部数据的记录*/
@property (nonatomic,strong)NSMutableDictionary *pullRequestFinishMapDic;
/**记录属性的字典*/
@property (nonatomic,strong)NSMutableDictionary *propertyDic;
@end

@implementation CustomizedCollectionViewController

-(instancetype)init{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIConfig];
    [self navigationConfig];
    
    if(self.navigationController){
        [self refreshIfShould];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"pdType"];
}

-(void)navigationConfig{
    NSArray *left                  = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 刷新
-(void)refreshIfShould{
    if(self.totalProductNum == 0){
        [self.collectionView.mj_header beginRefreshing];
    }
    else{
        [self.collectDataSource resetDataSource:self.dataSourceArrs];
    }
}

-(void)forceRefresh{
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 属性初始化
-(void)initialize{
    self.propertyDic             = @{}.mutableCopy;
    self.pullRequestFinishMapDic = @{}.mutableCopy;
    [self addObserver:self
           forKeyPath:@"pdType"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:NULL];
}

-(void)setPdType:(productType)pdType{
    _pdType = pdType;
    if(![self.propertyDic objectForKey:@(_pdType)]){
        [self.propertyDic setObject:@{
                                      @"flipPage":@(0),
                                      @"totalProductNum":@(0),
                                      @"pullRequestProductNum":@(eachPageSize),
                                      @"dataSourceArrs":@[].mutableCopy
                                      }.mutableCopy
                             forKey:@(_pdType)];
    }
}

-(NSInteger)flipPage{
    return [self.propertyDic[@(_pdType)][@"flipPage"] integerValue];
}

-(void)setFlipPage:(NSInteger)flipPage{
    self.propertyDic[@(_pdType)][@"flipPage"] = @(flipPage);
}

-(NSInteger)totalProductNum{
    return [self.propertyDic[@(_pdType)][@"totalProductNum"] integerValue];
}

-(void)setTotalProductNum:(NSInteger)totalProductNum{
    self.propertyDic[@(_pdType)][@"totalProductNum"] = @(totalProductNum);
}

-(NSInteger)pullRequestProductNum{
    return [self.propertyDic[@(_pdType)][@"pullRequestProductNum"] integerValue];
}

-(void)setPullRequestProductNum:(NSInteger)pullRequestProductNum{
    self.propertyDic[@(_pdType)][@"pullRequestProductNum"] = @(pullRequestProductNum);
}

-(NSMutableArray*)dataSourceArrs{
    return self.propertyDic[@(_pdType)][@"dataSourceArrs"];
}

-(void)setDataSourceArrs:(NSMutableArray *)dataSourceArrs{
    self.propertyDic[@(_pdType)][@"dataSourceArrs"] = dataSourceArrs;
}

#pragma mark - pdType KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"pdType"])
    {
        if(!self.pullRequestFinishMapDic[@(self.pdType)]){
            [_collectionView.mj_footer resetNoMoreData];
        }
        else{
            if([self.pullRequestFinishMapDic[@(self.pdType)] boolValue]){
                [_collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }
}

#pragma mark - UI
-(void)UIConfig{
    //配置layout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 4, 0, 4);
    layout.columnCount = CollectViewColumnCount;
    layout.minimumColumnSpacing = 4.0f;
    layout.minimumInteritemSpacing = 4.0f;
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5" alpha:1];
    self.collectionView.dataSource = self.collectDataSource;
    self.collectionView.delegate = self.collectDataSource;
    self.collectionView.scrollsToTop = NO;
    __weak typeof(self)weakSelf = self;
    self.collectDataSource.callback = ^(NSIndexPath *indexPath,AVObject *object){
        [weakSelf pushIntoCommodityDitailsControllerWithIndexPath:indexPath object:object];
    };
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.bounces = YES;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.view addSubview:self.collectionView];
    //创建约束
    [self.collectionView makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.view.leading);
        make.trailing.equalTo(weakSelf.view.trailing);
        make.top.equalTo(weakSelf.view.top);
        make.bottom.equalTo(weakSelf.view.bottom);
    }];
    [self resetTitleWithType:self.pdType];
}

#pragma mark - 数据源
-(CollectionViewDataSource*)collectDataSource{
    if(!_collectDataSource){
        _collectDataSource = [[CollectionViewDataSource alloc] initWithDelegate:self];
    }
    return _collectDataSource;
}

//刷新数据
-(void)refreshData{
    //未刷新成功过的使用规定的每页条数，否则刷新总条数
    NSInteger size = self.totalProductNum<eachPageSize?eachPageSize:self.totalProductNum;
    [RequestData queryProductWithType:self.pdType
                                 skinSize:0
                                 size:size
                          completiton:^(NSArray *arrs,NSError *error){
                              if(!error){
                                  self.dataSourceArrs = arrs.mutableCopy;
                                  [self calculateFlipPage];
                                  [self.collectDataSource resetDataSource:self.dataSourceArrs];
                              }
                              else{
                                  NSLog(@"商品下拉刷新失败！%@",error);
                                  [MBProgressHUD showError:@"商品刷新失败！"];
                                  [self calculateFlipPage];
                                  [self.collectDataSource resetDataSource:self.dataSourceArrs];
                              }
                              [_collectionView.mj_header endRefreshing];
    }];
}

//加载更多数据
-(void)loadMoreData{
    if(self.totalProductNum > 0){
        [RequestData queryProductWithType:self.pdType
                                     skinSize:self.totalProductNum
                                     size:self.pullRequestProductNum
                              completiton:^(NSArray *arrs,NSError *error){
                                  if(!error){
                                      if(arrs.count>0){
                                          [self.dataSourceArrs addObjectsFromArray:arrs];
                                          [self calculateFlipPage];
                                          [self.collectDataSource resetDataSource:self.dataSourceArrs];
                                      }
                                      else{
                                          if(!self.pullRequestFinishMapDic[@(self.pdType)]){
                                              self.pullRequestFinishMapDic[@(self.pdType)] = @(YES);
                                              [_collectionView.mj_footer endRefreshingWithNoMoreData];
                                              return;
                                          }
                                          
                                      }
                                  }
                                  else{
                                      NSLog(@"商品上拉刷新失败！%@",error);
                                      [MBProgressHUD showError:@"商品加载失败！"];
                                  }
                                  // 结束刷新
                                  [_collectionView.mj_footer endRefreshing];
        }];
    }
}

//计算当前已翻页数，上拉需要
-(void)calculateFlipPage{
    self.totalProductNum       = self.dataSourceArrs.count;
    self.flipPage              = self.totalProductNum/eachPageSize;
    self.pullRequestProductNum = eachPageSize-self.totalProductNum%eachPageSize;
}

-(void)resetTitleWithType:(productType)type{
    switch (type) {
        case productType_women:
        {
            self.title = @"全部女装";
        }
            break;
        case productType_sweater:
        {
            self.title = @"毛衣";
        }
            break;
        case productType_sportswear:
        {
            self.title = @"运动装";
        }
            break;
        case productType_shirt:
        {
            self.title = @"衬衣";
        }
            break;
        case productType_pantyHose:
        {
            self.title = @"裤袜";
        }
            break;
        case productType_overcoat:
        {
            self.title = @"大衣";
        }
            break;
        case productType_minkCoat:
        {
            self.title = @"貂皮大衣";
        }
            break;
        case productType_jacket:
        {
            self.title = @"外套";
        }
            break;
        case productType_formal:
        {
            self.title = @"正装";
        }
            break;
        case productType_dress:
        {
            self.title = @"连衣裙";
        }
            break;
        case productType_downJacket:
        {
            self.title = @"羽绒服";
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - callBack
-(void)pushIntoCommodityDitailsControllerWithIndexPath:(NSIndexPath *)indexPath object:(AVObject *)object{
    CommodityDetailsViewController *vc = [[CommodityDetailsViewController alloc] initWithObject:object];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
