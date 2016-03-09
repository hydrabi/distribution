//
//  CustomMWPhotoBrowser.m
//  Distribution
//
//  Created by Hydra on 16/1/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomMWPhotoBrowser.h"
#import "CustomShare.h"
#import "NSArray+Addition.h"
@interface CustomMWPhotoBrowser ()

@end

@implementation CustomMWPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(shareButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    NSArray *leftBarButton = [NSArray navigationItemsWithImageName:@"photoBrowser_back" target:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"";
}

-(void)shareButtonClick{
//    [[CustomShare shareManager] showShareMenuWithObject:self.];
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
