//
//  SBAddScoreCell.h
//  scoreBoard
//
//  Created by sylar on 15/9/30.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "SBBasicTableViewCell.h"
@class SBAddScoreCell;
////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol SBAddScoreCellDelegate <NSObject>

@optional

/**
 *  change text field
 *
 *  @param cell <#cell description#>
 *  @param text <#text description#>
 */
- (void) SBAddScoreCell:(SBAddScoreCell *)cell didChangeInputText:(NSString *)text;

/**
 *  click auto calculate
 *
 *  @param cell <#cell description#>
 *  @param win  yes for 麻将的时候一个人赢
 */
- (void) SBAddScoreCell:(SBAddScoreCell *)cell didTapAutoCalculate:(BOOL)win;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreCell : SBBasicTableViewCell

@property (nonatomic, weak) id<SBAddScoreCellDelegate> delegate;

- (void) setWithName:(NSString *)name;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////