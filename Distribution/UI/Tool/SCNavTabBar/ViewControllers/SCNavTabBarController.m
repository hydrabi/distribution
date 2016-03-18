//
//  SCNavTabBarController.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBarController.h"
#import "CommonMacro.h"
#import "SCNavTabBar.h"
#import "UIColor+Addition.h"
#import "CustomArrowButton.h"
#import "SharePopSelectView.h"
#import "SharePopSelectViewDelegate.h"
#import "HomeViewController.h"

@interface SCNavTabBarController () <UIScrollViewDelegate, SCNavTabBarDelegate,SharePopSelectViewDelegate,UIGestureRecognizerDelegate>
{
//    NSInteger       _currentIndex;              // current page index
    NSMutableArray  *_titles;                   // array of children view controller's title
    
    SCNavTabBar     *_navTabBar;                // NavTabBar: press item on it to exchange view
    UIScrollView    *_mainView;                 // content view
}

@property (nonatomic,weak)UIViewController *parentController;

@property (nonatomic,strong)SharePopSelectView *sharePopSelectView;

@property (nonatomic,strong)UITapGestureRecognizer *tapGesture;

@property (nonatomic,weak)CustomArrowButton *arrowButton;


@end

@implementation SCNavTabBarController

#pragma mark - Life Cycle
#pragma mark -

- (id)initWithShowArrowButton:(BOOL)show
{
    self = [super init];
    if (self)
    {
        _showArrowButton = show;
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    self = [super init];
    if (self)
    {
        _subViewControllers = subViewControllers;
    }
    return self;
}

- (id)initWithParentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        [self addParentController:viewController];
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController showArrowButton:(BOOL)show;
{
    self = [self initWithSubViewControllers:subControllers];
    
    _showArrowButton = show;
    [self addParentController:viewController];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConfig];
    [self viewConfig];
    // Iinitialize value
    self.currentIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self.homeDelegate hadScrollToViewWithIndex:currentIndex];
}

#pragma mark - Private Methods
#pragma mark -

- (void)initConfig
{
    
    _navTabBarColor = _navTabBarColor ? _navTabBarColor : NavTabbarColor;
    _navTabBarLineColor = TAB_BAR_LINE_COLOR;
    _scrollAnimation = NO;
    
    // Load all title of children view controllers
    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    for (UIViewController *viewController in _subViewControllers)
    {
        [_titles addObject:viewController.title];
    }
}

- (void)viewInit
{
    // Load NavTabBar and content view to show on window
//    _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT) showArrowButton:_showArrowButton];
    _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectZero showArrowButton:_showArrowButton];
    _navTabBar.delegate = self;
    _navTabBar.backgroundColor = _navTabBarColor;
    _navTabBar.lineColor = _navTabBarLineColor;
    _navTabBar.itemTitles = _titles;
    _navTabBar.buttonTitleFontSize = BUTTONTITLEFONT;
    _navTabBar.arrowImage = _navTabBarArrowImage;
    [_navTabBar updateData];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _navTabBar.frame.origin.y + _navTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _navTabBar.frame.origin.y - _navTabBar.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _mainView.delegate = self;
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.pagingEnabled = YES;
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    _mainView.scrollsToTop = NO;
    [self.view addSubview:_mainView];
    [self.view addSubview:_navTabBar];
    
    [_navTabBar makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self.view.leading);
        make.top.equalTo(self.view.top);
        make.trailing.equalTo(self.view.trailing);
        make.height.equalTo(NAV_TAB_BAR_HEIGHT);
    }];
    
    [_mainView makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self.view.leading);
        make.top.equalTo(_navTabBar.bottom);
        make.trailing.equalTo(self.view.trailing);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.tapGesture.delegate = self;
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, DOT_COORDINATE, SCREEN_WIDTH, _mainView.frame.size.height);
        [self addChildViewController:viewController];
        [_mainView addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
        
    }];
}

-(void)tapGestureAction:(UITapGestureRecognizer*)tap{
    if(self.sharePopSelectView.superview){
        [self.sharePopSelectView hideSharePopView];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    CGPoint point = [touch locationInView:self.view];
    if(self.sharePopSelectView.superview && !CGRectContainsPoint(self.sharePopSelectView.frame, point)){
        return YES;
    }
    [self.homeDelegate resignSerchBarFirstResponse];
    return NO;
}

#pragma mark - Public Methods
#pragma mark -
- (void)setNavTabbarColor:(UIColor *)navTabbarColor
{
    // prevent set [UIColor clear], because this set can take error display
    CGFloat red, green, blue, alpha;
    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
    {
        navTabbarColor = NavTabbarColor;
    }
    _navTabBarColor = navTabbarColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    
    self.parentController = viewController;
    UIView *parentView = self.view.superview;
    [self.view makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(parentView.leading);
        make.trailing.equalTo(parentView.trailing);
        make.top.equalTo(parentView.top);
        make.bottom.equalTo(parentView.bottom);
    }];
}

#pragma mark - Scroll View Delegate Methods
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_sharePopSelectView hideSharePopView];
    self.currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = self.currentIndex;
}

#pragma mark - SCNavTabBarDelegate Methods
#pragma mark -
- (void)itemDidSelectedWithIndex:(NSInteger)index button:(UIButton *)button
{
    if(index == NavTabBarButtonType_classify){
//        CustomArrowButton *arrButton = (CustomArrowButton*)button;
//        self.arrowButton = arrButton;
//        if(!_sharePopSelectView){
//            _sharePopSelectView = [SharePopSelectView instanceSharePopSelectViewWithParentView:self.view buttonFrame:button.frame];
//            _sharePopSelectView.delegate = self;
//        }
//        [_sharePopSelectView showSharePopView];
        
        
    }
    else{
        [self scrollToViewWithIndex:index];
    }
    
}

- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height
{
    if (pop)
    {
        [UIView animateWithDuration:0.5f animations:^{
            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, height + NAV_TAB_BAR_HEIGHT);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, NAV_TAB_BAR_HEIGHT);
        }];
    }
    [_navTabBar refresh];
}

#pragma mark - SharePopSelectViewDelegate
-(void)didSelectWithCellType:(productType)cellType{
    NSLog(@"selected index %ld",(long)cellType);
    [self scrollToViewWithIndex:(NSInteger)NavTabBarButtonType_classify];
    [self.homeDelegate hadSelectSharePopSelectTableViewCellType:cellType];
}

-(void)didHideSharePopView{
    if(self.arrowButton){
        [self.arrowButton transformRotationAbove:YES];
    }
}

-(void)didShowSharePopView{
    if(self.arrowButton){
        [self.arrowButton transformRotationAbove:NO];
    }
}

#pragma mark - Scroll To Specific View
-(void)scrollToViewWithIndex:(NSInteger)index{
    [_navTabBar configerTitleColorWithSelectedIndex:(NSInteger)NavTabBarButtonType_classify];
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, DOT_COORDINATE) animated:_scrollAnimation];
}

@end

