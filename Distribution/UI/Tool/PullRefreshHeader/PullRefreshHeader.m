//
//  PullRefreshHeader.m
//  pullRefreshSample
//
//  Created by 毕志锋 on 15/11/12.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#import "PullRefreshHeader.h"
#import <AudioToolbox/AudioToolbox.h>
#ifdef __OBJC__
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#endif

static CGFloat pullthreshold = 60;

@interface PullRefreshHeader()

/**
 *  上次刷新时间label
 */
@property (nonatomic,strong) UILabel *lastRefreshTimeLabel;

/**
 *  刷新提示
 */
@property (nonatomic,strong) UILabel *pullTips;

/**
 *  当前状态
 */
@property (nonatomic,assign) refreshStatus status;

@property (nonatomic,strong) NSString *lastRefreshTimeKey;

@end

@implementation PullRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithParentView:(UITableView*)parentView yPosition:(CGFloat)yPosition{
    self = [super initWithFrame:CGRectMake(0, yPosition-[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if(self){
        self.lastRefreshTimeKey = @"lastRefreshTimeKey";
        self.status = refreshStatus_spaceDeficiency;
        [self configUIWithParentView:parentView yPosition:yPosition];
        
    }
    return self;
}

-(void)configUIWithParentView:(UITableView*)parentView yPosition:(CGFloat)yPosition{
    if(!self.lastRefreshTimeLabel){
        
        self.lastRefreshTimeLabel               = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lastRefreshTimeLabel.textColor     = [UIColor blackColor];
        self.lastRefreshTimeLabel.font          = [UIFont systemFontOfSize:12];
        self.lastRefreshTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lastRefreshTimeLabel];

        self.pullTips                           = [[UILabel alloc] initWithFrame:CGRectZero];
        self.pullTips.textColor                 = [UIColor blackColor];
        self.pullTips.font                      = [UIFont systemFontOfSize:12];
        self.pullTips.text                      = [self refreshTitleWithStatus:self.status];
        self.pullTips.textAlignment             = NSTextAlignmentCenter;
        [self addSubview:self.pullTips];
        
        [parentView addSubview:self];
        [self fillInLastRefreshTimeLabel];
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self.lastRefreshTimeLabel mas_makeConstraints:^(MASConstraintMaker * make){
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.bottom).offset(@(-5));
            make.leading.lessThanOrEqualTo(self.leading).offset(16).with.priorityMedium();
            make.trailing.lessThanOrEqualTo(self.trailing).offset(@(-16)).with.priorityMedium();
            make.top.equalTo(self.pullTips.bottom).offset(@5);
        }];
        
        [self.pullTips makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self);
            make.leading.lessThanOrEqualTo(self.leading).offset(16).with.priorityMedium();
            make.trailing.lessThanOrEqualTo(self.trailing).offset(@(-16)).with.priorityMedium();
        }];
        
        [self makeConstraints:^(MASConstraintMaker *make){
            make.leading.equalTo(parentView.leading).offset(0);
            make.top.equalTo(yPosition-[UIScreen mainScreen].bounds.size.height);
            make.width.equalTo(parentView.width);
            make.height.equalTo([UIScreen mainScreen].bounds.size.height);
        }];
    }
}

-(NSString*)refreshTitleWithStatus:(refreshStatus)status{
    NSString *title = @"";
    switch (status) {
        case refreshStatus_spaceDeficiency:
            title = @"下拉可以刷新";
            break;
        case  refreshStatus_spaceEnough:
            title = @"松开可以刷新";
            break;
        case refreshStatus_loading:
            title = @"加载中...";
            break;
        default:
            title = @"";
            break;
    }
    return title;
}

#pragma mark - LastRefreshTime

-(void)updateLastRefreshTime{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSString *strDate = [format stringFromDate:nowDate];
    self.lastRefreshTimeLabel.text = [NSString stringWithFormat:@"上次刷新时间：%@",strDate];
    
    [[NSUserDefaults standardUserDefaults] setObject:strDate forKey:self.lastRefreshTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)fillInLastRefreshTimeLabel{
    NSString *strDate = [[NSUserDefaults standardUserDefaults] objectForKey:self.lastRefreshTimeKey];
    if(strDate.length>0){
        self.lastRefreshTimeLabel.text = [NSString stringWithFormat:@"上次刷新时间：%@",strDate];
    }
    else{
        self.lastRefreshTimeLabel.text = @"";
    }
}

-(void)setStatus:(refreshStatus)status{
    self.pullTips.text = [self refreshTitleWithStatus:status];
    _status = status;
}


-(void)parentViewDidScroll:(UIScrollView*)parentView{
    if(self.status != refreshStatus_loading){
        if(parentView.contentOffset.y<(-pullthreshold)){
            if(self.status != refreshStatus_spaceEnough){
                //下拉超过阀值，改变状态
                self.status = refreshStatus_spaceEnough;
                [self fillInLastRefreshTimeLabel];
            }
        }
        else{
            //下拉少于阀值，改变状态
            if(self.status != refreshStatus_spaceDeficiency){
                self.status = refreshStatus_spaceDeficiency;
                [self fillInLastRefreshTimeLabel];
            }
        }
    }
}

-(void)parentViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.status != refreshStatus_loading){
        //下拉松手，超过阀值，改变状态
        if(scrollView.contentOffset.y<-pullthreshold){
            self.status = refreshStatus_loading;
            [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                      animations:^{
                [scrollView setContentInset:UIEdgeInsetsMake(pullthreshold, 0, 0, 0)];
            }
                                      completion:^(BOOL finish){
                                          
                                              [self.delegate shouldRefreshNow];
                                              [self performSelector:@selector(parentViewStopLodingWithParentView:) withObject:scrollView afterDelay:2.0];
                                          
            }];
        }
    }
}

-(void)parentViewStopLodingWithParentView:(UIScrollView*)parentView{
    [self updateLastRefreshTime];
    [self playMsgSound];
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.3 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [parentView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                              }
                              completion:^(BOOL finish){
                                  self.status = refreshStatus_spaceDeficiency;
                              }];
    
}


-(void)playMsgSound{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msg" ofType:@"wav"];
    NSURL *url = [[NSURL alloc] initWithString:path];
    SystemSoundID sound;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &sound);
    AudioServicesPlaySystemSound(sound);
}

@end
