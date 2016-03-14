//
//  PersonalMainNameTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainNameTableViewCell.h"
#import "UIColor+Addition.h"
#import "ImageManager.h"
#import "PersonalMainMacro.h"
#import "PersonalMainOrderCellButton.h"
@interface PersonalMainNameTableViewCell()
@property (nonatomic,strong)NSMutableArray *buttonsArr;
@end

@implementation PersonalMainNameTableViewCell

- (void)awakeFromNib {
    
    self.headImage.layer.cornerRadius = PersonalMainNameTableViewCell_HeadImageWidthAndHeight/2;
    self.headImage.clipsToBounds = YES;
    
    if(!self.buttonsArr){
        self.buttonsArr = @[].mutableCopy;
        for(PersonalMainOrderCellButtonType i = PersonalMainOrderCellButtonType_myPoint;i<=PersonalMainOrderCellButtonType_myCollect;i++){
            PersonalMainOrderCellButton *button = [[PersonalMainOrderCellButton alloc] initWithButtonType:i font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor]];
            [self.toolBarBackgroundView addSubview:button];
            [self.buttonsArr addObject:button];
            [button addTarget:self action:@selector(orderCellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
        }
        
        [self UIConfig];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)UIConfig{
    UIButton *lastButton = nil;
    for(int i=0;i<self.buttonsArr.count;i++){
        PersonalMainOrderCellButton *button = self.buttonsArr[i];
        //配置按钮约束，按照按钮个数等分tabbar宽度
        [button makeConstraints:^(MASConstraintMaker *make){
            if(!lastButton){
                make.leading.equalTo(self.toolBarBackgroundView.leading);
            }
            else{
                make.width.equalTo(lastButton.width);
                make.leading.equalTo(lastButton.trailing).offset(@0);
            }
            make.top.equalTo(self.toolBarBackgroundView.top);
            make.bottom.equalTo(self.toolBarBackgroundView.bottom);
            if(i==self.buttonsArr.count-1){
                make.trailing.equalTo(self.toolBarBackgroundView.trailing).offset(@0);
            }
        }];
        
        lastButton = button;
    }
    
}

-(void)reloadUserData{

    if([[PersonlInfoManager shareManager] hadLogin]){
        AVUser *user = [AVUser currentUser];
        [self.headImage setImage:[ImageManager userHeadImageWithImageName:user]];
    }
    else{
        [self.headImage setImage:[UIImage imageNamed:@"personalHeader_headDefault"]];
    }
}

-(void)orderCellButtonClick:(UIButton*)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(mainButtonClickWithType:)]){
        [self.delegate mainButtonClickWithType:sender.tag];
    }
}

//用户已经登录
//-(void)userHadLogin{
//    AVUser *user = [AVUser currentUser];
//    [self.headImage setImage:[ImageManager userHeadImageWithImageName:user]];
//    if(user.nickname.length>0){
//        self.nickNameLabel.text = user.nickname;
//    }
//    else{
//        self.nickNameLabel.text = @"未设置";
//    }
//    
//    if(user.signature.length>0){
//        self.signatureLabel.text = user.signature;
//    }
//    else{
//        self.signatureLabel.text = @"未设置";
//    }
//}
//
////用户未登录
//-(void)userAnonymous{
//    self.nickNameLabel.text = @"未登录";
//    self.signatureLabel.text = @"点击登录";
//    [self.headImage setImage:[ImageManager userHeadDefaultImage]];
//}

@end
