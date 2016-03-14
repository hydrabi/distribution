//
//  PersonalManagerAddressNormalTableViewCell.m
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalManagerAddressNormalTableViewCell.h"
#import "UIColor+Addition.h"
#import "PersonalManagerAddressMacro.h"
@interface PersonalManagerAddressNormalTableViewCell()

@end

@implementation PersonalManagerAddressNormalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"747474" alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)resetValueWith:(NSString*)str{
    if(str.length == 0){
        self.titleLabel.text = PersonalManagerAddrestNomalCellDefaultTitle;
    }
    else{
        self.titleLabel.text = str;
    }
}

@end
