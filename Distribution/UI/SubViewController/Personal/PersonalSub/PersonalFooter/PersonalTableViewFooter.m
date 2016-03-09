//
//  PersonalTableViewFooter.m
//  Distribution
//
//  Created by Hydra on 15/12/31.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import "PersonalTableViewFooter.h"
#import "UIColor+Addition.h"
@interface PersonalTableViewFooter()

@end

@implementation PersonalTableViewFooter

+(instancetype)instancePersonalTableViewFooter{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PersonalTableViewFooter class]) owner:nil options:nil];
    return arr[0];
}

-(void)awakeFromNib{
    [self.logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logoutButton setBackgroundColor:[UIColor colorWithHexString:@"ff5000" alpha:1]];
    self.logoutButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.logoutButton.layer.cornerRadius = 5.0f;
    self.logoutButton.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
}

-(void)setLogin{
    [self.logoutButton setTitle:@"登录" forState:UIControlStateNormal];
}

-(void)setLogout{
    [self.logoutButton setTitle:@"安全退出登录" forState:UIControlStateNormal];
}

@end
