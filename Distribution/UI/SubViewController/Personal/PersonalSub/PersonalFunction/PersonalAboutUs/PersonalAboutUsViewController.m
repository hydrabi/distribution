//
//  PersonalAboutUsViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/10.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalAboutUsViewController.h"
#import "NSArray+Addition.h"
#import "UIColor+Addition.h"
@interface PersonalAboutUsViewController ()
@property (nonatomic,weak)IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation PersonalAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIConfig];
    [self navigationConfig];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView*)imageView{
    if(_imageView == nil){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 736)];
        [_imageView setImage:[UIImage imageNamed:@"aboutUs_background"]];
    }
    return _imageView;
}

-(void)UIConfig{
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee" alpha:1];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame), 736)];
    [self.scrollView addSubview:self.imageView];
}

-(void)navigationConfig{
    NSArray *left                  = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems  = left;
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
