//
//  CustomBaseProductListDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/3/6.
//  Copyright © 2016年 distribution. All rights reserved.
//

@protocol CustomBaseProductListDataSourceDelegate <NSObject>

@optional

/**
 *  通知委托点击了某个cell
 *
 *  @param object cell所对应的AVobject
 */
-(void)didSelectRowWithObject:(AVObject*)object;

-(NSString*)titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCellEditingStyle)editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
