//
//  PersonalMainOrderTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/28.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalMainOrderTableViewCell.h"
#import "PersonalMainMacro.h"
@interface PersonalMainOrderTableViewCell()

@property (nonatomic,strong)NSMutableArray *buttonsArr;

@end

@implementation PersonalMainOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if(!self.buttonsArr){
        self.buttonsArr = @[].mutableCopy;
        for(PersonalMainOrderCellButtonType i =PersonalMainOrderCellButtonType_notPay;i<=PersonalMainOrderCellButtonType_Return;i++){
            PersonalMainOrderCellButton *button = [[PersonalMainOrderCellButton alloc] initWithButtonType:i];
            [self.contentView addSubview:button];
            [self.buttonsArr addObject:button];
            button.tag = i;
        }
        [self configUI];
    }
}

-(void)configUI{
    
    UIButton *lastButton = nil;
    for(int i=0;i<self.buttonsArr.count;i++){
        PersonalMainOrderCellButton *button = self.buttonsArr[i];
        //配置按钮约束，按照按钮个数等分tabbar宽度
        [button makeConstraints:^(MASConstraintMaker *make){
            if(!lastButton){
                make.leading.equalTo(self.contentView.leading);
            }
            else{
                make.width.equalTo(lastButton.width);
                make.leading.equalTo(lastButton.trailing).offset(@0);
            }
            make.top.equalTo(self.top);
            make.bottom.equalTo(self.bottom);
            if(i==self.buttonsArr.count-1){
                make.trailing.equalTo(self.contentView.trailing).offset(@0);
            }
        }];
        
        
        //重置按钮的属性
//        BOOL highlighted = (i==self.currentIndex)?YES:NO;
//        [button configAttributeWithHighlighted:highlighted];
//        [button addTarget:self action:@selector(customButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        lastButton = button;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
