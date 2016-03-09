//
//  CustomPresentViewController.h
//  Distribution
//
//  Created by Hydra on 15/12/25.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPresentViewController : UIViewController

+(instancetype)shareInstance;

-(void)tapGestureTap:(UITapGestureRecognizer*)tap;
@end
