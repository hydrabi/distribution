//
//  CustomTabBar.m
//  FoodDelivered
//
//  Created by Hydra on 15/11/27.
//  Copyright © 2015年 hydra. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomTabBarButton.h"
#import "UIColor+Addition.h"
static CGFloat tabBarHeight = 44.0f;

@interface CustomTabBar()
/**
 *  存储TabBarButton的队列
 */
@property (nonatomic,strong) NSArray *buttonsArr;

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation CustomTabBar

-(instancetype)initWithButtonsArr:(NSArray*)buttonsArr defaultIndex:(NSInteger)defaultIndex{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, tabBarHeight)];
    if(self){
        self.buttonsArr = buttonsArr;
        if(defaultIndex>buttonsArr.count-1){
            _currentIndex = 0;
        }
        else{
            _currentIndex = defaultIndex;
        }
        [self configUI];
    }
    return self;
}

/**当前选中索引改变都要更改按钮属性*/
-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    for(CustomTabBarButton *button in self.buttonsArr){
        BOOL highlighted = (currentIndex == button.tag)?YES:NO;
        [button configAttributeWithHighlighted:highlighted];
    }
    
}

#pragma mark - 外部接口
-(CustomTabBarButton*)getCurrentSelectButton{
    if(_currentIndex<self.buttonsArr.count){
        return self.buttonsArr[_currentIndex];
    }
    return nil;
}

-(NSInteger)getCurrentIndex{
    return self.currentIndex;
}

-(void)switchToSpecificIndex:(NSInteger)index{
    if(index<self.buttonsArr.count){
        self.currentIndex = index;
        if(self.delegate && [self.delegate respondsToSelector:@selector(CustomTabBar:selectedIndex:)]){
            [self.delegate CustomTabBar:self selectedIndex:index];
        }
    }
}

#pragma mark - 定制当前需要使用的tabbar按钮
+(CustomTabBar*)customFoodDeliverTabBar{
    CustomTabBarButton *button = [[CustomTabBarButton alloc] initWithButtonType:CustomTabBarButtonType_home];
    CustomTabBarButton *button1 = [[CustomTabBarButton alloc] initWithButtonType:CustomTabBarButtonType_classify];
    CustomTabBarButton *button2 = [[CustomTabBarButton alloc] initWithButtonType:CustomTabBarButtonType_discover];
    CustomTabBarButton *button3 = [[CustomTabBarButton alloc] initWithButtonType:CustomTabBarButtonType_shoppingCar];
    CustomTabBarButton *button4 = [[CustomTabBarButton alloc] initWithButtonType:CustomTabBarButtonType_personal];
    
    CustomTabBar *tabBar = [[CustomTabBar alloc] initWithButtonsArr:@[
                                                                      button,
                                                                      button1,
                                                                      button2,
                                                                      button3,
                                                                      button4
                                                                      ]
                                                       defaultIndex:0];
    return tabBar;
}

#pragma mark - 配置UI
-(void)configUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *lastButton = nil;
    for(int i=0;i<self.buttonsArr.count;i++){
        CustomTabBarButton *button = self.buttonsArr[i];
        [self addSubview:button];
        //配置按钮约束，按照按钮个数等分tabbar宽度
        [button makeConstraints:^(MASConstraintMaker *make){
            if(!lastButton){
                make.leading.equalTo(self.leading);
            }
            else{
                make.width.equalTo(lastButton.width);
                make.leading.equalTo(lastButton.trailing).offset(@0);
            }
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
            if(i==self.buttonsArr.count-1){
                make.trailing.equalTo(self.trailing).offset(@0);
            }
        }];
        
        button.tag = i;
        //重置按钮的属性
        BOOL highlighted = (i==self.currentIndex)?YES:NO;
        [button configAttributeWithHighlighted:highlighted];
        [button addTarget:self action:@selector(customButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        lastButton = button;
    }
}

/**按钮点击事件*/
-(void)customButtonClick:(CustomTabBarButton*)button{
    [self switchToSpecificIndex:button.tag];
}

@end
