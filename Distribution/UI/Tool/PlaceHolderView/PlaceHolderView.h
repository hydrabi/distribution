//
//  PlaceHolderView.h
//  Distribution
//
//  Created by Hydra on 15/12/27.
//  Copyright © 2015年 distribution. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PlaceHolderView(name) @interface PlaceHolderView##name:PlaceHolderView @end  @implementation PlaceHolderView##name - (NSString *)xibName{    return NSStringFromClass([name class]); } @end

@protocol PlaceHolderInitDelegate <NSObject>

/**从xib加载的初始化方法*/
- (void)commonInitCallByPlaceHolderView;

@end

@interface PlaceHolderView : UIView

/**xibName,使用PlaceHolderView(name)定义将使其默认变成类名*/
- (NSString *)xibName;

@end
