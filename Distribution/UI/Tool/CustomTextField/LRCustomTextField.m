//
//  LRCustomTextField.m
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "LRCustomTextField.h"
#import "UIColor+Addition.h"
PlaceHolderView(LRCustomTextField)

@implementation LRCustomTextField

-(void)commonInitCallByPlaceHolderView{
    self.layer.borderColor = [UIColor colorWithHexString:@"#c4c4c4" alpha:1].CGColor;
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    self.clipsToBounds = YES;
    
    self.preNameLabel.font = [UIFont systemFontOfSize:18.0f];
    self.preNameLabel.textColor = [UIColor colorWithHexString:@"#5a5a5a" alpha:1];
    self.textField.font = [UIFont systemFontOfSize:16.0f];
}

@end
