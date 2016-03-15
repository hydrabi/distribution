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
#import "CustomShare.h"

@interface CustomMWPhotoBrowser ()<UIActionSheetDelegate>
@property (nonatomic,copy)NSArray *photos;
@end

@implementation CustomMWPhotoBrowser

-(instancetype)initWithPhotos:(NSArray *)photosArray delegate:(id <MWPhotoBrowserDelegate>)delegate {
    self = [super initWithDelegate:delegate];
    if(self){
        self.photos = photosArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStyleBordered target:self action:@selector(moreButtonClick)];
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

-(void)moreButtonClick{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信",@"保存到手机", nil];
    [actionSheet showInView:self.view];
}

-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        
    }
    else if (buttonIndex == 1){
        if(self.photos!=nil && self.photos.count>self.currentIndex){
            NSArray *imageArr = @[self.photos[self.currentIndex]];
            [[CustomShare shareManager] saveImages:imageArr completiton:^(BOOL success){
                if(success){
                    [MBProgressHUD showSuccess:@"保存到手机成功！"];
                }
                else{
                    [MBProgressHUD showError:@"保存到手机失败！"];
                }
            }];
        }
        
    }
}

@end
