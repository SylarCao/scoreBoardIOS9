//
//  SBMainViewCell.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "SBBasicTableViewCell.h"
@class SBMainViewCell;
////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SBMainViewCellDelegate <NSObject>

@optional
/**
 *  tap 3 times delegate
 *
 *  @param cell  <#cell description#>
 *  @param index <#index description#>
 */
- (void) SBMainViewCell:(SBMainViewCell *)cell didTripleTapIndex:(NSInteger)index;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewCell : SBBasicTableViewCell

@property (nonatomic, weak) id<SBMainViewCellDelegate> delegate;

/**
*  <#Description#>
*
*  @param score       <#score description#>
*  @param roundNumber <#roundNumber description#>
*/
- (void) cellUpdateWithScores:(NSArray *)score roundNumber:(NSString *)roundNumber;

/**
 *  total score cell
 *
 *  @param totalScore <#totalScore description#>
 */
- (void) setWithTotalScore:(NSArray *)totalScore;



@end
////////////////////////////////////////////////////////////////////////////////////////////////////////







