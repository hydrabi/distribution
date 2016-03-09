//
//  CustomPresentViewController.m
//  Distribution
//
//  Created by Hydra on 15/12/25.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "CustomPresentViewController.h"
#import "UIColor+Addition.h"

@interface CustomPresentViewController ()

@end

@implementation CustomPresentViewController

+(instancetype)shareInstance{
    static CustomPresentViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[CustomPresentViewController alloc] init];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self gestureConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
-(void)UIConfig{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.54];
}

-(void)gestureConfig{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTap:)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)tapGestureTap:(UITapGestureRecognizer*)tap{
//    [self hide];
}

@end
