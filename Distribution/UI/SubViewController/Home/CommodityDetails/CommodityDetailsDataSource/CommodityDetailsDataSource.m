//
//  CommodityDetailsDataSource.m
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CommodityDetailsDataSource.h"
#import "CDMainTableViewCell.h"
#import "CommodityDetailsMacro.h"
#import "CDIntroduceTableViewCell.h"
#import "CDIntroduceTableViewCellDelegate.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CDImageTableViewCellDelegate.h"
#import "CDImageTableViewCell.h"
#import "MJRefresh.h"

static NSString *tableViewMainCellIndentifier = @"tableViewMainCellIndentifier";
static NSString *tableViewIntroduceCellIndentitier = @"tableViewIntroduceCellIndentitier";
static NSString *tableViewImageCellIndentitier = @"tableViewImageCellIndentitier";

@interface CommodityDetailsDataSource()<UITableViewDataSource,UITableViewDelegate,CDIntroduceTableViewCellDelegate,CDImageTableViewCellDelegate,CDMainTableViewCellDelegate>

/**
 *  从about中传递过来的tableView
 */
@property (nonatomic,weak) UITableView *tableView;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
/**
 *  有多少张图片
 */
@property (nonatomic,strong)NSMutableArray *imageDataArr;
/**
 *  商品
 */
@property (nonatomic,strong)AVObject *object;

@end

@implementation CommodityDetailsDataSource

-(instancetype)initWithTableView:(UITableView*)tableView object:(AVObject*)object{
    self = [super init];
    if(self){
        self.tableView            = tableView;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshData];
        }];
        self.object             = object;

        self.dataTypeArr          = [[NSMutableArray alloc] init];
        [self configDataTypeArr];
        [self registerCellNib];
    }
    return self;
}

-(void)reloadTableViewData{
    [self.tableView reloadData];
}

-(void)refreshData{
    [self.object refreshInBackgroundWithBlock:^(AVObject *object,NSError *error){
        if(!error){
            [self reloadTableViewData];
        }
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewMainCellNib = [UINib nibWithNibName:NSStringFromClass([CDMainTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewMainCellNib forCellReuseIdentifier:tableViewMainCellIndentifier];
    
    UINib *tableViewIntroduceCellNib = [UINib nibWithNibName:NSStringFromClass([CDIntroduceTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewIntroduceCellNib forCellReuseIdentifier:tableViewIntroduceCellIndentitier];
    
    UINib *tableViewImageCellNib = [UINib nibWithNibName:NSStringFromClass([CDImageTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewImageCellNib forCellReuseIdentifier:tableViewImageCellIndentitier];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    [self.dataTypeArr removeAllObjects];
    [self.dataTypeArr addObject: @[
                                   @(CommodityDetailsCellType_Main),
                                   ].mutableCopy
     ];
    
    NSDictionary *localData = [self.object objectForKey:@"localData"];
    
    if([localData objectForKey:@"productdesc"]){
        [self.dataTypeArr addObject:@[
                                      @(CommodityDetailsCellType_Introduce)
                                      ].mutableCopy];
    }
    
    if([localData objectForKey:@"imgs"]){
        NSArray *imgs = [localData objectForKey:@"imgs"];
        self.imageDataArr = imgs.mutableCopy;
        
        NSInteger number = ceil((double)self.imageDataArr.count/CommodityDetailsImageCellImageCount);
        
        NSMutableArray *temp = @[].mutableCopy;
        for(NSInteger i = 0;i<number;i++){
            [temp addObject:@(CommodityDetailsCellType_Image)];
        }
        [self.dataTypeArr addObject:temp];
    }
}
/**获取指定indexPath的type*/
-(CommodityDetailsCellType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    CommodityDetailsCellType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *arr = self.dataTypeArr[indexPath.section];
        if(arr.count>indexPath.row){
            type = (CommodityDetailsCellType)[arr[indexPath.row] integerValue];
            
        }
    }
    return type;
}

-(void)resetDataSource:(NSMutableDictionary *)data{
    [self configDataTypeArr];
    [self reloadTableViewData];
}
#pragma mark - 获取相应的cell高度
-(CGFloat)heightWithIntroduceTableDataType:(CommodityDetailsCellType)type indexPath:(NSIndexPath*)indexPath{
    CGFloat height = 0;
    switch (type) {
        case CommodityDetailsCellType_Main:
            height = CommodityDetailsMainCellHeight;
            break;
            
        case CommodityDetailsCellType_Introduce:
        {
            height =[self.tableView fd_heightForCellWithIdentifier:tableViewIntroduceCellIndentitier configuration:^(CDIntroduceTableViewCell *cell) {
                [cell resetValueWithObject:self.object];
            }];
        }
            break;
            
        case CommodityDetailsCellType_Image:
        {
            height = CommodityDetailsImageCellHeight;
            height = (ScreenSize.width-CommodityDetailsImageCellLeadingOffset*2-CommodityDetailsImageCellOffset*(CommodityDetailsImageCellImageCount-1))/3*CommodityDetailsImageAspectRadio+5;
        }
            break;
        default:
            height = 0;
            break;
    }
    return height;
}


#pragma mark - UITableViewDelegateAndDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataTypeArr.count>section){
        NSArray *arr = self.dataTypeArr[section];
        return arr.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataTypeArr.count;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self heightWithIntroduceTableDataType:[self getSpecificCellTypeWithIndexPath:indexPath] indexPath:indexPath];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    CommodityDetailsCellType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    switch (type) {
        case CommodityDetailsCellType_Main:
        {
            CDMainTableViewCell *mainCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewMainCellIndentifier forIndexPath:indexPath];
            [mainCell resetValueWithObject:self.object];
            mainCell.delegate = self;
            cell = (UITableViewCell*)mainCell;
        }
            break;
        
        case CommodityDetailsCellType_Introduce:
        {
            CDIntroduceTableViewCell *introduceCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewIntroduceCellIndentitier forIndexPath:indexPath];
            cell = (UITableViewCell*)introduceCell;
            [introduceCell resetValueWithObject:self.object];
        }
            break;
        case CommodityDetailsCellType_Image:
        {
            CDImageTableViewCell *imageCell = [self.tableView dequeueReusableCellWithIdentifier:tableViewImageCellIndentitier forIndexPath:indexPath];
            cell = (UITableViewCell*)imageCell;
            imageCell.delegate = self;
            [imageCell configImgeWithImageArr:self.imageDataArr indexPath:indexPath];
        }
            break;
        default:
        {
            
        }
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CDIntroduceTableViewCellDelegate
-(void)introduceButtonClick{
    
}

#pragma mark - CDImageTableViewCellDelegate
-(void)imageCell:(CDImageTableViewCell*)imageCell imageClickWithIndex:(NSInteger)index{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:imageCell];
    NSInteger row = indexPath.row;
    NSInteger clickIndex = CommodityDetailsImageCellImageCount*row + index;
    if(self.delegate && [self.delegate respondsToSelector:@selector(imageClickWithArr:clickedIndex:)]){
        [self.delegate imageClickWithArr:self.imageDataArr clickedIndex:clickIndex];
    }
}

#pragma mark - CDMainTableViewCellDelegate
-(void)clickImageCell:(CDMainTableViewCell *)imageCell{
    NSDictionary *localData = [self.object objectForKey:@"localData"];
    NSString *productImgUrlStr = [localData objectForKey:@"productimg"];
    if(productImgUrlStr.length>0){
        if(self.delegate && [self.delegate respondsToSelector:@selector(imageClickWithArr:clickedIndex:)]){
            [self.delegate imageClickWithArr:@[productImgUrlStr].mutableCopy clickedIndex:0];
        }
    }
}

@end
