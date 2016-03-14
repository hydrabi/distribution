//
//  CustomInputTextViewTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CustomInputTextViewTableViewCell.h"
#import "UIColor+Addition.h"
#import "PersonalManagerAddressMacro.h"
@implementation CustomInputTextViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.textView.placeholder = [NSString stringWithFormat:@"详细地址，长度不超过%d字",PersonalManagerAddrestDetailMaxLength];
    self.textView.font = [UIFont systemFontOfSize:16.0f];
    self.textView.textColor = [UIColor colorWithHexString:@"747474" alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
