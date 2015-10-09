//
//  SBMainViewCell.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBBasicTableViewCell.h"

@interface SBMainViewCell : SBBasicTableViewCell

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
