//
//  SBGame.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSUInteger, SBGameScoreType) {
    sb_game_score_type_normal= 0,
    sb_game_score_type_abnormal,
};
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBGame : NSObject

@property (nonatomic, strong) NSDictionary *score;  // uid => score
@property (nonatomic, assign) SBGameScoreType type;  // normal =  分数总和为 0


/**
 *  <#Description#>
 *
 *  @param scores <#scores description#>
 *  @param type   <#type description#>
 *
 *  @return <#return value description#>
 */
- (id) initWithScores:(NSDictionary *)scores type:(SBGameScoreType)type;


/**
 *  <#Description#>
 *
 *  @param uid <#uid description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger) getScoreForPlayer:(NSString *)uid;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////