//
//  CustomInputTextViewTableViewCell.h
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"
@interface CustomInputTextViewTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet PlaceHolderTextView *textView;
-(void)resetAdviceFeedbackPlaceholder;
@end
