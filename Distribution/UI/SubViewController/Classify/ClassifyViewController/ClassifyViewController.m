//
//  ClassifyViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "ClassifyViewController.h"
#import "CollectionViewDataSource.h"
#import "ClassifyMacro.h"
#import "UIColor+Addition.h"
#import "ClassifyViewCollectViewCell.h"
#import "RequestData.h"
#import "CustomizedCollectionViewController.h"

@interface ClassifyViewController ()<UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
/**数据源*/
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataTypeConfig];
    [self UIConfig];
    [self registerReuseCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
-(void)UIConfig{
    self.title = @"分类";
    //配置layout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
    layout.columnCount = CollectViewColumnCount;
    //每一列之间的距离
    layout.minimumColumnSpacing = 1.0f;
    //每一列里面每个item之间的距离
    layout.minimumInteritemSpacing = 1.0f;
    //collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5" alpha:1];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.bounces = YES;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.collectionView];
    //创建约束
    __weak typeof(self)weakSelf = self;
    [self.collectionView makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(weakSelf.view.leading);
        make.trailing.equalTo(weakSelf.view.trailing);
        make.top.equalTo(weakSelf.view.top);
        make.bottom.equalTo(weakSelf.view.bottom);
    }];
}

#pragma mark - 数据源
-(void)dataTypeConfig{
    self.dataArr = @[@(productType_women),
                     @(productType_summer),
                     @(productType_autumn),
                     @(productType_overcoat),
                     @(productType_sweater),
                     @(productType_fachion),
                     @(productType_jacket),
                     @(productType_downJacket),
                     @(productType_pantyHose),
                     @(productType_dress),
                     @(productType_minkCoat)].mutableCopy;
}


-(void)registerReuseCell{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ClassifyViewCollectViewCell class]) bundle:nil] forCellWithReuseIdentifier:CollectViewCellReuseIdentifier];
}

-(void)registerReuseView{
//    [self.delegate.collectionView registerClass:[CollectionViewFooter class]
//                     forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
//                            withReuseIdentifier:CollectViewReuseFooterIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyViewCollectViewCell *cell =
    (ClassifyViewCollectViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectViewCellReuseIdentifier
                                                                    forIndexPath:indexPath];
    
    NSInteger index = indexPath.section*CollectViewColumnCount +indexPath.row;
    if(self.dataArr.count>index){
        productType type = (productType)[self.dataArr[indexPath.row] integerValue];
        [cell resetValueWithType:type];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = indexPath.section*CollectViewColumnCount +indexPath.row;
    if(self.dataArr.count>index){
        productType type = (productType)[self.dataArr[indexPath.row] integerValue];
        CustomizedCollectionViewController *vc= [[CustomizedCollectionViewController alloc] init];
        vc.pdType = type;
        [self.navigationController pushViewController:vc animated:YES];
        [vc refreshIfShould];
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-CollectViewColumnCount+1)/CollectViewColumnCount;
    CGFloat height = CollectViewCellNormalHeight;
    if(indexPath.row == 0){
        height = CollectViewCellNormalHeight*2;
    }
    else{
        height = CollectViewCellNormalHeight;
    }
    return CGSizeMake(width, height);
}

@end
