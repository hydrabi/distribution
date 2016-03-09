//
//  CDIntroduceTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/1/4.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "CDIntroduceTableViewCell.h"
#import "UIColor+Addition.h"
@interface CDIntroduceTableViewCell()
@property (nonatomic,strong)AVObject *object;
@end

@implementation CDIntroduceTableViewCell

- (void)awakeFromNib {
    self.introduceTitleLabel.text               = @"产品介绍";
    self.introduceTitleLabel.textColor          = [UIColor colorWithHexString:@"303030" alpha:1];
    self.introduceTitleLabel.font               = [UIFont systemFontOfSize:20.0f];

    self.introduceLabel.font                    = [UIFont systemFontOfSize:14.0f];
    self.introduceLabel.textColor               = [UIColor colorWithHexString:@"4a4a4a" alpha:1];
    self.introduceLabel.text                    = @"";

    [self.introduceCopyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.introduceCopyButton setTitle:@"复制" forState:UIControlStateNormal];
    [self.introduceCopyButton setBackgroundColor:[UIColor colorWithHexString:@"ff4400" alpha:1]];
    self.introduceCopyButton.layer.cornerRadius = 5.0f;
    self.introduceCopyButton.clipsToBounds      = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)introduceButtonClickAction:(id)sender {
    [UIPasteboard generalPasteboard].string = self.introduceLabel.text;
    [MBProgressHUD showSuccess:@"已复制到粘贴板"];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(introduceButtonClick)]){
        [self.delegate introduceButtonClick];
    }
}

-(void)resetValueWithObject:(AVObject*)object{
    self.object = object;
    NSDictionary *localData = [object objectForKey:@"localData"];
    self.introduceLabel.text = [localData objectForKey:@"productdesc"];
}
@end
