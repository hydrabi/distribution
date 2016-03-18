//
//  DiscoverSubDetailViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "DiscoverSubDetailViewController.h"
#import "NSArray+Addition.h"
#import "UIColor+Addition.h"
#import "DiscoverSubDetailTitleTableViewCell.h"
#import "DiscoverSubDetailImageTableViewCell.h"
#import "DiscoverSubDetailIntroduceTableViewCell.h"
#import "DiscoverSubDetailTimeTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString *discoverSubDetailTitleTableViewCellIndentifier = @"discoverSubDetailTitleTableViewCellIndentifier";
static NSString *discoverSubDetailImageTableViewCellIndentifier = @"discoverSubDetailImageTableViewCellIndentifier";
static NSString *discoverSubDetailIntroduceTableViewCellIndentifier = @"discoverSubDetailIntroduceTableViewCellIndentifier";
static NSString *discoverSubDetailTimeTableViewCellIndentifier = @"discoverSubDetailTimeTableViewCellIndentifier";

@interface DiscoverSubDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,assign)DiscoverTableDataType type;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@property (nonatomic,strong)AVObject *object;
@end

@implementation DiscoverSubDetailViewController

-(instancetype)initWithObject:(AVObject*)object type:(DiscoverTableDataType)type{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if(self){
        self.object = object;
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self registerCellNib];
    [self configDataTypeArr];
    [self navigitionConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIConfig{
    if(self.type == DiscoverTableDataType_newActivity){
        self.title = @"活动";
    }
    else if (self.type == DiscoverTableDataType_notification){
        self.title = @"通知";
    }
    self.tableView.backgroundColor     = Global_TableViewBackgroundColor;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    self.dataTypeArr = [[NSMutableArray alloc] init];
    [self configDataTypeArr];
    [self registerCellNib];
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
}
#pragma mark - 点击事件
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    self.dataTypeArr = @[@(DiscoverSubDetailCellType_title),
                         @(DiscoverSubDetailCellType_image),
                         @(DiscoverSubDetailCellType_introduce),
                         @(DiscoverSubDetailCellType_time)].mutableCopy;
}

/**获取指定indexPath的type*/
-(DiscoverSubDetailCellType)getSpecificCellTypeWithIndexPath:(NSIndexPath*)indexPath{
    DiscoverSubDetailCellType type;
    if(self.dataTypeArr.count>indexPath.row){
        type = [self.dataTypeArr[indexPath.row] integerValue];
    }
    return type;
}

#pragma mark - 注册tableView要用到的所有CellNib

-(void)registerCellNib{
    UINib *discoverSubDetailTitleTableViewCellNib = [UINib nibWithNibName:NSStringFromClass([DiscoverSubDetailTitleTableViewCell class]) bundle:nil];
    [self.tableView registerNib:discoverSubDetailTitleTableViewCellNib forCellReuseIdentifier:discoverSubDetailTitleTableViewCellIndentifier];
    
    UINib *discoverSubDetailImageTableViewCellNib = [UINib nibWithNibName:NSStringFromClass([DiscoverSubDetailImageTableViewCell class]) bundle:nil];
    [self.tableView registerNib:discoverSubDetailImageTableViewCellNib forCellReuseIdentifier:discoverSubDetailImageTableViewCellIndentifier];
    
    UINib *discoverSubDetailIntroduceTableViewCellNib = [UINib nibWithNibName:NSStringFromClass([DiscoverSubDetailIntroduceTableViewCell class]) bundle:nil];
    [self.tableView registerNib:discoverSubDetailIntroduceTableViewCellNib forCellReuseIdentifier:discoverSubDetailIntroduceTableViewCellIndentifier];
    
    UINib *discoverSubDetailTimeTableViewCellNib = [UINib nibWithNibName:NSStringFromClass([DiscoverSubDetailTimeTableViewCell class]) bundle:nil];
    [self.tableView registerNib:discoverSubDetailTimeTableViewCellNib forCellReuseIdentifier:discoverSubDetailTimeTableViewCellIndentifier];
}

#pragma mark - 获取相应的cell高度
-(CGFloat)heightWithIntroduceTableDataType:(DiscoverSubDetailCellType)type indexPath:(NSIndexPath*)indexPath{
    CGFloat height = 0;
    switch (type) {
        case DiscoverSubDetailCellType_title:
            height = DiscoverSubDetailTitleTableViewCellHeight;
            break;
            
        case DiscoverSubDetailCellType_image:
        {
            height = DiscoverSubDetailImageTableViewCellHeight;
        }
            break;
            
        case DiscoverSubDetailCellType_introduce:
        {
            height =[self.tableView fd_heightForCellWithIdentifier:discoverSubDetailIntroduceTableViewCellIndentifier configuration:^(DiscoverSubDetailIntroduceTableViewCell *cell) {
                [cell resetValueWithObject:self.object];
            }];
        }
            break;
        case DiscoverSubDetailCellType_time:
        {
            height = DiscoverSubDetailTimeTableViewCellHeight;
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
    return self.dataTypeArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverSubDetailCellType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    return [self heightWithIntroduceTableDataType:type indexPath:indexPath];
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.1;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.1;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    DiscoverSubDetailCellType type = [self getSpecificCellTypeWithIndexPath:indexPath];
    switch (type) {
        case DiscoverSubDetailCellType_title:
        {
            DiscoverSubDetailTitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:discoverSubDetailTitleTableViewCellIndentifier forIndexPath:indexPath];
            cell = (UITableViewCell*)titleCell;
        }
            break;
        case DiscoverSubDetailCellType_image:
        {
            DiscoverSubDetailImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:discoverSubDetailImageTableViewCellIndentifier forIndexPath:indexPath];
            cell = (UITableViewCell*)imageCell;
        }
            break;
        case DiscoverSubDetailCellType_introduce:
        {
            DiscoverSubDetailIntroduceTableViewCell *introduceCell = [tableView dequeueReusableCellWithIdentifier:discoverSubDetailIntroduceTableViewCellIndentifier forIndexPath:indexPath];
            cell = (UITableViewCell*)introduceCell;
        }
            break;
        case DiscoverSubDetailCellType_time:
        {
            DiscoverSubDetailTimeTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:discoverSubDetailTimeTableViewCellIndentifier forIndexPath:indexPath];
            cell = (UITableViewCell*)titleCell;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
