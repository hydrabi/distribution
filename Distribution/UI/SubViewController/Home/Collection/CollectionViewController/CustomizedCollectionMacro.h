//
//  CustomizedCollectionMacro.h
//  Distribution
//
//  Created by Hydra on 15/12/17.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

#ifndef CustomizedCollectionMacro_h
#define CustomizedCollectionMacro_h

#define ScreenSize                    [UIScreen mainScreen].bounds.size

/* Collection View layout*/

#define CollectViewSectionInsetTop                      5.0f
#define CollectViewSectionInsetLeft                     5.0f
#define CollectViewSectionInsetBottom                   7.0f
#define CollectViewSectionInsetRight                    5.0f
#define CollectViewColumnCount                          2
#define CollectViewBackgroundColor             [UIColor whiteColor]

/* Collection View cell*/
#define CollectViewCellBorderColor       [UIColor colorWithHexString:@"999999" alpha:1].CGColor
#define CollectViewCellHeight            230.0f
#define CollectViewCellLongerHeight      260.0f
#define CollectViewCellAspectRadio       1.7f
#define CollectViewCellReuseIdentifier   @"CollectViewCellReuseIdentifier"
#define CollectViewReuseFooterIdentifier @"CollectViewReuseFooterIdentifier"

#endif /* CustomizedCollectionMacro_h */
