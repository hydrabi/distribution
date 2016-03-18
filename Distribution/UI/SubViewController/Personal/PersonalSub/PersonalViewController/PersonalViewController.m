//
//  PersonalViewController.m
//  Distribution
//
//  Created by Hydra on 15/12/30.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PersonalViewController.h"
#import "UIColor+Addition.h"
#import "PersonalMacro.h"
#import "PersonalTableViewDataSource.h"
#import "PersonalTableViewDataSourceDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "UIAlertView+Addition.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "ImageManager.h"
#import "PersonalAgeViewController.h"
#import "PersonalViewControllerDelegate.h"
#import "PersonalGenderViewController.h"
#import "PersonalTextFieldInputViewController.h"
#import "PersonalLocationUIViewController.h"
#import "CustomControllerTitleView.h"
#import "PersonalNicknameAndSignatureFunction.h"
#import "NSArray+Addition.h"
#import "PersonalAddressListViewController.h"
@interface PersonalViewController ()<PersonalTableViewDataSourceDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PersonalViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  数据源
 */
@property (strong,nonatomic) PersonalTableViewDataSource *dataSource;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configDataSoucre];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange) name:Notification_LoginStatusChange object:nil];
}

//tableViewCell分割线左边距为0
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,PersonalTableViewCellLeftSeparatorInset,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,PersonalTableViewCellLeftSeparatorInset,0,0)];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - action
/**登录状态改变*/
-(void)loginStatusChange{
    [self.dataSource reloadTableViewData];
    [self.dataSource resetTableViewFooter];
    AVUser *user = [AVUser currentUser];
    if(!user){
        [self returnButtonClick];
    }
}

#pragma mark - configUI
-(void)configUI{
    self.title = Global_PersonalSubNavigationTitleName;
    self.tableView.backgroundColor = PersonalTableViewBackgroundColor;
    [self navigationItemConfig];
}

//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] configTabBarConstraint];
    
}
-(void)navigationItemConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
}
#pragma mark - 配置数据源
-(void)configDataSoucre{
    self.dataSource = [[PersonalTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
}

#pragma mark - PersonalTableViewDataSourceDelegate
-(void)didSelectRowOfAboutDataType:(PersonalTableDataType)type{
    if(![[PersonlInfoManager shareManager] hadLogin]){
        [self.dataSource footerButtonClick];
        return;
    }
    
    switch (type) {
        case PersonalTableDataType_head:
        {
            [self headImagePickManage];
        }
            break;
        case PersonalTableDataType_age:
        {
            PersonalAgeViewController *ageVc = [[PersonalAgeViewController alloc] init];
            ageVc.delegate = self;
            [self.navigationController pushViewController:ageVc animated:YES];
            [[AppDelegate getRootController] hideTabbar];
        }
            break;
        case PersonalTableDataType_gender:
        {
            PersonalGenderViewController *genderVc = [[PersonalGenderViewController alloc] init];
            genderVc.delegate = self;
            [self.navigationController pushViewController:genderVc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalTableDataType_telephone:
        {
            PersonalTextFieldInputViewController *telephoneVc = [[PersonalTextFieldInputViewController alloc] initWithPersonalViewTextFieldInputType:PersonalViewTextFieldInputType_telephone];
            telephoneVc.delegate = self;
            [self.navigationController pushViewController:telephoneVc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalTableDataType_weixin:
        {
            PersonalTextFieldInputViewController *weixinVc = [[PersonalTextFieldInputViewController alloc] initWithPersonalViewTextFieldInputType:PersonalViewTextFieldInputType_weixin];
            weixinVc.delegate = self;
            [self.navigationController pushViewController:weixinVc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalTableDataType_qq:
        {
            PersonalTextFieldInputViewController *qqVc = [[PersonalTextFieldInputViewController alloc] initWithPersonalViewTextFieldInputType:PersonalViewTextFieldInputType_qq];
            qqVc.delegate = self;
            [self.navigationController pushViewController:qqVc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalTableDataType_location:{
            
            PersonalLocationUIViewController *locationVc = [[PersonalLocationUIViewController alloc] init];
            locationVc.delegate = self;
            [self.navigationController pushViewController:locationVc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalTableDataType_nickname:{
            PersonalNicknameAndSignatureFunction *vc = [[PersonalNicknameAndSignatureFunction alloc] initWithType:PersonalInputAttributeType_nickname];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            [[AppDelegate getRootController]hideTabbar];
        }
            break;
        case PersonalTableDataType_manageAdress:
        {
            PersonalAddressListViewController *vc = [[PersonalAddressListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case PersonalTableDataType_modifyPassword:
        {
            [[AccountNavigationManager shareInstance] showNavWithType:AccountReleateViewControllerType_forgetPassword];
        }
            break;
        default:
            break;
    }
    
}

-(void)headImagePickManage{
    if([[PersonlInfoManager shareManager] hadLogin]){
        UIActionSheet *sheet;
        sheet = [[UIActionSheet alloc] initWithTitle:@"头像修改"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
        [sheet showInView:[AppDelegate getRootController].view];
    }
}

#pragma mark - Image capture


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if([[PersonlInfoManager shareManager] hadLogin]){
        AVUser *user = [AVUser currentUser];
        if(user.headImage.length>0){
            [ImageManager deleteImageAtPath:user.headImage user:user];
        }
        [ImageManager saveImageToDisk:image user:user];
        [self.dataSource reloadTableViewData];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    switch (buttonIndex) {
        case 0:
        {
            //系统版本小于8.0
            if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0){
                ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
                if(status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusRestricted){
                    [UIAlertView alertWithTitle:@"请在设置->隐私->照片中打开照片访问权限"];
                    return;
                }
            }
            else{
                PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
                if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusRestricted) {
                    [UIAlertView alertWithTitle:@"请在设置->隐私->照片中打开照片访问权限"];
                    return;
                }
            }
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            NSString *mediaType =AVMediaTypeVideo;
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            
            if(authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                [UIAlertView alertWithTitle:@"请在设置->隐私->相机中打开相机权限"];
                return;
            }
            else{
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - PersonalViewControllerDelegate
-(void)userPropertySave{
    [self.dataSource reloadTableViewData];
    [self.dataSource resetTableViewFooter];
}

@end
