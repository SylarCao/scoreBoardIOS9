//
//  SBHistoryViewCell.h
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "SBBasicTableViewCell.h"
#import "MGSwipeTableCell.h"
@class SBLocalSaveModel;
@class SBHistoryViewCell;
////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SBHistoryViewCellDelegate <NSObject>

@optional
- (void)SBHistoryViewCellDidTapDelete:(SBHistoryViewCell *)cell; // 点击了删除
- (BOOL)SBHistoryViewCellShouldSwipe:(SBHistoryViewCell *)cell;  //  是否允许左滑

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHistoryViewCell : MGSwipeTableCell

@property (nonatomic, weak) id<SBHistoryViewCellDelegate> delegateTap;

/**
 *  get cell id
 *
 *  @return <#return value description#>
 */
+ (NSString *) getCellId;

/**
 *  添加删除按钮
 */
- (void) setWithDeleteButton;

/**
 *  set with data
 *
 *  @param data <#data description#>
 */
- (void) setWithData:(SBLocalSaveModel *)data;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////

