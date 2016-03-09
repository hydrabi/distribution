//
//  FavoriteDataSourceDelegate.h
//  Distribution
//
//  Created by Hydra on 16/1/2.
//  Copyright © 2016年 distribution. All rights reserved.
//

@protocol FavoriteDataSourceDelegate <NSObject>

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
