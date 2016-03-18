//
//  CollectionViewDataSource.m
//  Distribution
//
//  Created by Hydra on 15/12/17.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "CollectionViewDataSource.h"
#import "CustomizedCollectionViewController.h"
#import "CustomizedCollectionMacro.h"
#import "CollectionViewCell.h"
#import "CollectionViewFooter.h"
#import "UIScrollView+EmptyDataSet.h"

@interface CollectionViewDataSource()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**collectView回调*/
@property (nonatomic,weak) CustomizedCollectionViewController *delegate;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation CollectionViewDataSource

-(instancetype)initWithDelegate:(CustomizedCollectionViewController*)delegate{
    self = [super init];
    if(self){
        self.delegate = delegate;
        self.dataArr = @[].mutableCopy;
        self.delegate.collectionView.emptyDataSetSource = self;
        self.delegate.collectionView.emptyDataSetDelegate = self;
        [self registerReuseCell];
        [self registerReuseView];
    }
    return self;
}

-(void)resetDataSource:(NSMutableArray*)data{
    self.dataArr = data.mutableCopy;
    [self.delegate.collectionView reloadData];
}

-(void)registerReuseCell{
    [self.delegate.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:CollectViewCellReuseIdentifier];
}

-(void)registerReuseView{
    [self.delegate.collectionView registerClass:[CollectionViewFooter class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:CollectViewReuseFooterIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    double temp = (double)self.dataArr.count/CollectViewColumnCount;
//    NSInteger number = (NSInteger)ceil(temp);
//    if(section<number-1){
//        return CollectViewColumnCount;
//    }
//    else if(section == number-1){
//        NSInteger remainder = self.dataArr.count%CollectViewColumnCount;
//        if(remainder == 0){
//            return CollectViewColumnCount;
//        }
//        else{
//            return remainder;
//        }
//    }
//    return CollectViewColumnCount;
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    double temp = (double)self.dataArr.count/CollectViewColumnCount;
//    NSInteger number = (NSInteger)ceil(temp);
//    return number;
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell =
    (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectViewCellReuseIdentifier
                                                                                forIndexPath:indexPath];
    
    NSInteger index = indexPath.section*CollectViewColumnCount +indexPath.row;
    if(self.dataArr.count>index){
        AVObject *object = self.dataArr[index];
        [cell resetValueWith:object];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate.homeDelegate respondsToSelector:@selector(pushIntoCommodityDitailsControllerWithIndexPath:object:)]){
        NSInteger index = indexPath.section*CollectViewColumnCount +indexPath.row;
        if(self.dataArr.count>index){
            AVObject *object = self.dataArr[index];
            [self.delegate.homeDelegate pushIntoCommodityDitailsControllerWithIndexPath:indexPath object:object];
        }
        
    }
    else{
        NSInteger index = indexPath.section*CollectViewColumnCount +indexPath.row;
        if(self.dataArr.count>index){
            AVObject *object = self.dataArr[index];
            self.callback(indexPath,object);
        }
        
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (ScreenSize.width-(CollectViewColumnCount+1)*CollectViewSectionInsetLeft)/CollectViewColumnCount;
    CGFloat height = width*CollectViewCellAspectRadio;
    if(((indexPath.row)%4==0 && indexPath.row>0) || indexPath.row == 1){
        height = width*CollectViewCellAspectRadio;
    }
    else{
        height = width*CollectViewCellAspectRadio+30;
    }
    return CGSizeMake(width, height);
}

#pragma mark - DZNEmptyDataSetSource 当页面为空时出现的提示
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"现在还没有商品~";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"请刷新一下~";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
@end
