//
//  CDImageTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CDImageTableViewCell.h"
#import "UIImageView+Addition.h"
@interface CDImageTableViewCell()
@property (nonatomic,strong)UITapGestureRecognizer *tap0;
@property (nonatomic,strong)UITapGestureRecognizer *tap1;
@property (nonatomic,strong)UITapGestureRecognizer *tap2;
@end

@implementation CDImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if(!_tap0){
        self.tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTagAction:)];
        self.image0.userInteractionEnabled = YES;
        [self.image0 addGestureRecognizer:self.tap0];
    }
    
    if(!_tap1){
        self.tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTagAction:)];
        self.image1.userInteractionEnabled = YES;
        [self.image1 addGestureRecognizer:self.tap1];
    }
    
    if(!_tap2){
        self.tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTagAction:)];
        self.image2.userInteractionEnabled = YES;
        [self.image2 addGestureRecognizer:self.tap2];
    }
    self.image0.contentMode          = UIViewContentModeScaleAspectFill;
    self.image1.contentMode          = UIViewContentModeScaleAspectFill;
    self.image2.contentMode          = UIViewContentModeScaleAspectFill;
    self.image0.clipsToBounds = YES;
    self.image1.clipsToBounds = YES;
    self.image2.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configImgeWithImageArr:(NSMutableArray*)imageArr indexPath:(NSIndexPath*)indexPath{
    NSInteger row = indexPath.row;
    NSString *imgName0 = imageArr.count>row*3?imageArr[row*3]:@"";
    NSString *imgName1 = imageArr.count>(row*3+1)?imageArr[row*3+1]:@"";
    NSString *imgName2 = imageArr.count>(row*3+2)?imageArr[row*3+2]:@"";
    
    if(imgName0.length>0){
        [_image0 downloadImageWithUrl:imgName0];
    }
    else{
        [_image0 setImage:nil];
    }
    
    if(imgName1.length>0){
        [_image1 downloadImageWithUrl:imgName1];
    }
    else{
        [_image1 setImage:nil];
    }
    
    if(imgName2.length>0){
        [_image2 downloadImageWithUrl:imgName2];
    }
    else{
        [_image2 setImage:nil];
    }
}

-(void)imageTagAction:(UITapGestureRecognizer*)tap{
    UIImageView *imageView = (UIImageView*)tap.view;
    NSInteger index = imageView.tag;
    if(self.delegate && [self.delegate respondsToSelector:@selector(imageCell:imageClickWithIndex:)]){
        [self.delegate imageCell:self imageClickWithIndex:index];
    }
}

@end
