//
//  SharePopSelectView.m
//  YQTrack
//
//  Created by 毕志锋 on 15/9/10.
//  Copyright (c) 2015年 17track. All rights reserved.
//

#import "SharePopSelectView.h"
#import "UIColor+Addition.h"
#import "SharePopSelectViewTableViewCell.h"

static NSString * const tableViewCellReuseId = @"tableViewCellReuseId";
static NSString *cellIndentifier             = @"cellIdentifier";
static const CGFloat tableViewWidht          = 100.0;
static const CGFloat tableViewCellHeight     = 44.0f;

@interface SharePopSelectView()
/**
 *  share页面上的tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  数据源队列
 */
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
/**
 *  父视图
 */
@property (weak,nonatomic) UIView *parentView;
/**
 *  隐藏动画
 */
@property (strong,nonatomic) CAAnimationGroup *hideGroup;
/**
 *  展示动画
 */
@property (strong,nonatomic) CAAnimationGroup *showGroup;

@property (assign,nonatomic) CGRect buttonFrame;
/**当前选中行*/
@property (assign,nonatomic) NSInteger currentSelectRow;

@end

@implementation SharePopSelectView

+(instancetype)instanceSharePopSelectViewWithParentView:(UIView*)parent buttonFrame:(CGRect)buttonFrame
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SharePopSelectView" owner:nil options:nil];
    SharePopSelectView *selectView = (SharePopSelectView*)[nibView objectAtIndex:0];
    selectView.parentView          = parent;
    selectView.buttonFrame         = buttonFrame;
    [selectView configSelectView];
    return [nibView objectAtIndex:0];
}

-(void)awakeFromNib{
    self.currentSelectRow = 0;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,
                                                           0,
                                                           0,
                                                           0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,
                                                          0,
                                                          0,
                                                          0)];
    }
}

#pragma mark - 展示sharePopView
//展示sharePopView
-(void)showSharePopView{
    if(!self.superview){

        [self.parentView addSubview:self];
        [self.layer addAnimation:self.showGroup forKey:@"start"];
        self.layer.opacity = 1.0;
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(didShowSharePopView)]){
            [self.delegate didShowSharePopView];
        }
    }
    else{
        [self hideSharePopView];
        if(self.delegate && [self.delegate respondsToSelector:@selector(didHideSharePopView)]){
            [self.delegate didHideSharePopView];
        }
    }
}

//隐藏sharePopView
-(void)hideSharePopView{
    if(self.superview){
        [self.layer addAnimation:self.hideGroup forKey:@"end"];
        self.layer.opacity = 0.0;
    }
}

#pragma mark - UI
-(void)configSelectView{
    if(!self.dataSourceArray){
        [self configTabelView];
        [self configUI];
        [self configAnimation];
        
    }
}

/**
 *  配置tableView
 */
-(void)configTabelView{
    
        self.dataSourceArray = @[
                                 @(productType_overcoat),
                                 @(productType_trousers),
                                 @(productType_dress),
                                 @(productType_sweater),
                                 ].mutableCopy;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellReuseId];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self registerCellNib];
    
}

/**
 *  配置UI
 */
-(void)configUI{
    //设置锚点，右上角
//    self.layer.anchorPoint = CGPointMake(1, 0);
//    self.layer.cornerRadius = 5.0f;
//    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    CGFloat oringX = CGRectGetMinX(self.buttonFrame)-(tableViewWidht-CGRectGetWidth(self.buttonFrame))/2;
    CGFloat oringY = CGRectGetMaxY(self.buttonFrame);
    self.frame = CGRectMake(oringX,
                            oringY,
                            tableViewWidht,
                            tableViewCellHeight*self.dataSourceArray.count);
}

#pragma mark - 创建动画
/**
 *  创建动画
 */
-(void)configAnimation{
    [self configHideAniamtion];
    [self configShowAnimation];
}
/**
 *  隐藏动画
 */
-(void)configHideAniamtion{
    if(!self.hideGroup){
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scale setFromValue:@(1.0)];
        [scale setToValue:@(0.0)];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacity setFromValue:@(1.0)];
        [opacity setToValue:@(0.0)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.2;
        [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [group setAnimations:@[scale,opacity]];
        self.hideGroup = group;
        [group setValue:@"hide" forKey:@"hide"];
        self.hideGroup.delegate = self;
    }
}
/**
 *  展示动画
 */
-(void)configShowAnimation{
    if(!self.showGroup){
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [scale setFromValue:@(0.0)];
        [scale setToValue:@(1.0)];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [opacity setFromValue:@(0.0)];
        [opacity setToValue:@(1.0)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.2;
        [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [group setAnimations:@[scale,opacity]];
        [group setValue:@"show" forKey:@"show"];
        self.showGroup = group;
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(self.superview!=nil){
        [self removeFromSuperview];
    }
    
}

#pragma mark 手势事件
/**屏幕点击事件*/
//- (void)receiveTouchEvent:(NSNotification *)notification
//{
//    UIEvent *event = [notification.userInfo objectForKey:WINDOWN_TOUCH_EVENT_INFO_KEY]; //从NSNotification获得所有点击
//    UITouch *touch = [[event allTouches] anyObject]; //获得点击事件
//    CGPoint point = [touch locationInView:self.parentView]; //获得点击位置
//    
//    if (!CGRectContainsPoint(self.frame, point)) {
//        if(self.superview){
//            [self showSharePopView];
//        }
//    }
//}

#pragma mark - 响应indexpath的图片或者文字
//返回特定行的标题
-(NSString*)getSpecificTitleWithIndexPath:(NSIndexPath*)indexPath{
    NSString *result = @"";
    if(self.dataSourceArray.count>indexPath.row){
        productType type = [self.dataSourceArray[indexPath.row] integerValue];
        switch (type) {
            case productType_overcoat:
                result = NSLocalizedString(@"大衣", @"");
                break;
            case productType_trousers:
                result = NSLocalizedString(@"裤子", @"");
                break;
            case productType_dress:
                result = NSLocalizedString(@"连衣裙", @"");
                break;
            case productType_sweater:
                result = NSLocalizedString(@"毛衣", @"");
                break;
            default:
                break;
        }
        
    }
    return result;
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *cellNib                   = [UINib nibWithNibName:@"SharePopSelectViewTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    
}

#pragma mark - TableView source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SharePopSelectViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.titleLabel.text = [self getSpecificTitleWithIndexPath:indexPath];
    if(indexPath.row == self.currentSelectRow){
        cell.titleLabel.textColor = [UIColor colorWithHexString:@"#ff6f3b" alpha:1];
    }
    else{
        cell.titleLabel.textColor = [UIColor colorWithHexString:@"#555555" alpha:1];
    }
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectWithCellType:)]){
        if(self.dataSourceArray.count>indexPath.row){
            productType type = [self.dataSourceArray[indexPath.row] integerValue];
            [self.delegate didSelectWithCellType:type];
            [self showSharePopView];
            self.currentSelectRow = indexPath.row;
            [self.tableView reloadData];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableViewCell分割线左边距为76
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0, 0, 0) ];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
@end
