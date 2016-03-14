//
//  PlaceHolderTextView.m
//  V5Frame
//
//  Created by 毕志锋 on 15/7/9.
//  Copyright (c) 2015年 Hydra. All rights reserved.
//
#import "PlaceHolderTextView.h"
#import "UIColor+Addition.h"
CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

@interface PlaceHolderTextView()

@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation PlaceHolderTextView
#pragma mark -
#pragma mark Initialisation

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [self configUI];
}

-(void)configUI{
    self.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
    self.placeholderColor = [UIColor colorWithHexString:@"#000000" alpha:0.28];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - placeHolder
//当有字体的时候placeholder变透明
- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
//    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
//    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

//添加placeHolderLabel
- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        [_placeHolderLabel removeFromSuperview];
        _placeHolderLabel = nil;
        
        if (_placeHolderLabel == nil )
        {
            //光标位置
            CGFloat cursor = 5.0f;
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8+cursor,10,self.bounds.size.width - 16-cursor,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}



@end
