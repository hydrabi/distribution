//
//  ClassifyView.h
//  Distribution
//
//  Created by Hydra on 16/3/8.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyView : UIView
@property (nonatomic,strong)UITableView *tableView;

-(instancetype)initWithParentView:(UIView*)parentView;
-(void)show;
-(void)hide;
@end
