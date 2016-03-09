//
//  LRCustomTextField.h
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderView.h"
@interface LRCustomTextField : UIView<PlaceHolderInitDelegate>
@property (weak, nonatomic) IBOutlet UILabel *preNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end
