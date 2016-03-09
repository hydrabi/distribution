//
//  PersonalTableViewFooter.h
//  Distribution
//
//  Created by Hydra on 15/12/31.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTableViewFooter : UIView

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

+(instancetype)instancePersonalTableViewFooter;

-(void)setLogin;

-(void)setLogout;

@end
