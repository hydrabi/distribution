//
//  CustomImageAndTitleButton.m
//  Distribution
//
//  Created by Hydra on 16/1/3.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomImageAndTitleButton.h"
#import "NSString+Addition.h"
@interface CustomImageAndTitleButton()

@property (nonatomic,strong)NSString *buttonImage;

@property (nonatomic,strong)NSString *buttonTitle;

@property (nonatomic,assign)CGFloat middleOffset;

@property (nonatomic,assign)CGSize buttonImageSize;

@property (nonatomic,assign)CGSize buttonTitleSize;

@property (nonatomic,strong)UIFont *buttonFont;

@property (nonatomic,assign)CGFloat buttonHeight;

@end

@implementation CustomImageAndTitleButton

-(instancetype)initWithButtonImageName:(NSString*)imageName title:(NSString*)title middleOffset:(CGFloat)middleOffset buttonHeight:(CGFloat)buttonHeight titleFont:(UIFont*)font{
    self = [super init];
    if(self){
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        [self configButtonImageName:imageName title:title middleOffset:middleOffset buttonHeight:buttonHeight titleFont:font];
    }
    return self;
}

-(void)configButtonImageName:(NSString*)imageName title:(NSString*)title middleOffset:(CGFloat)middleOffset buttonHeight:(CGFloat)buttonHeight titleFont:(UIFont*)font{
    self.buttonImage = imageName;
    self.buttonTitle = title;
    self.middleOffset = middleOffset;
    self.buttonFont = font;
    self.buttonHeight = buttonHeight;
    
    [self.titleLabel setFont:font];
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self calculteImageAndTitleSize];
    [self setNeedsDisplay];
}

-(void)calculteImageAndTitleSize{
    UIImage *image = [UIImage imageNamed:self.buttonImage];
    if(image.size.height>self.buttonHeight-10){
        self.buttonImageSize = CGSizeMake(self.buttonHeight-10, self.buttonHeight-10);
    }
    else{
        self.buttonImageSize = image.size;
    }
    
    
    CGSize titleSize = [self.buttonTitle stringSizeWithLableHeight:self.buttonHeight width:CGFLOAT_MAX font:self.buttonFont];
    self.buttonTitleSize = titleSize;
}

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸
// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageAndTitleWidth = self.buttonImageSize.width+self.middleOffset+self.buttonTitleSize.width;
    if(contentRect.size.width<imageAndTitleWidth){
        return CGRectZero;
    }
    else{
        CGFloat x = (CGRectGetWidth(contentRect)-imageAndTitleWidth)/2+self.buttonImageSize.width+self.middleOffset;
        CGFloat y = (CGRectGetHeight(contentRect)-self.buttonTitleSize.height)/2;
        if(self.buttonImage.length == 0){
            y = (CGRectGetHeight(self.frame)-self.buttonTitleSize.height)/2;
        }
        return CGRectMake(x, y, self.buttonTitleSize.width, self.buttonTitleSize.height);
    }
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageAndTitleWidth = self.buttonImageSize.width+self.middleOffset+self.buttonTitleSize.width;
    if(contentRect.size.width<imageAndTitleWidth){
        return CGRectZero;
    }
    else{
        CGFloat x = (CGRectGetWidth(contentRect)-imageAndTitleWidth)/2;
        CGFloat y = (CGRectGetHeight(contentRect)-self.buttonImageSize.height)/2;
        return CGRectMake(x, y, self.buttonImageSize.width, self.buttonImageSize.height);
    }
}

@end
