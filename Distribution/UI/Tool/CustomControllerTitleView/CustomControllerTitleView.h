//
//  CustomControllerTitleView.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomControllerTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

+(instancetype)instanceCustomControllerTitleView;
@end
