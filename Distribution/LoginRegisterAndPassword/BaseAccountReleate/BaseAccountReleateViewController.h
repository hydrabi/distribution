//
//  BaseAccountReleateViewController.h
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginRegisterAndPasswordMacro.h"
static NSString *verifyButtonTextFieldTableViewCellReuseIdentifier = @"verifyButtonTextFieldTableViewCellReuseIdentifier";
static NSString *customPrefixInputTextFieldTableViewCellReuseIdentifier = @"customPrefixInputTextFieldTableViewCellReuseIdentifier";

@interface BaseAccountReleateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@property (nonatomic,assign,readonly)AccountReleateViewControllerType type;

-(instancetype)initWithType:(AccountReleateViewControllerType)type;
-(void)UIConfig;
-(void)navigitionConfig;
-(void)returnButtonClick;
-(void)configDataTypeArr;
-(void)mainButtonClick;
-(void)subButtonClick;
-(void)clearTextField;
-(AccountReleateCellType)getSpecificTypeWithIndexPath:(NSIndexPath*)indexPath;
@end
