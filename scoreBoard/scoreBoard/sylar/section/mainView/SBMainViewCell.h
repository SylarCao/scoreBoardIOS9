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
 *  score array
 *
 *  @param score <#score description#>
 */
- (void) cellUpdateWithScores:(NSArray *)score;

@end
