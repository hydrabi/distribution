//
//  VerifyButtonTextFieldTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/15.
//  Copyright © 2016年 distribution. All rights reserved.
//  注册，忘记密码用的验证cell

#import <UIKit/UIKit.h>

typedef void (^verifyButtonCallBack) (BOOL canVerify);

@protocol VerifyButtonTextFieldTableViewCellDelegate <NSObject>

-(void)verifyButtonClick:(void(^)(BOOL canVery))callBack;

@end

@interface VerifyButtonTextFieldTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *titleLabel;
@property (nonatomic,weak)IBOutlet UITextField *textField;
@property (nonatomic,weak)IBOutlet UIButton *verifyButton;
@property (nonatomic,weak)id<VerifyButtonTextFieldTableViewCellDelegate> delegate;
@property (nonatomic,copy)verifyButtonCallBack callBack;
@end
