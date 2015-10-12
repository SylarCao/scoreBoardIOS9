//
//  SBData.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SBGame.h"
#import "SBPerson.h"

@interface SBData : NSObject

@property (nonatomic, strong) NSMutableArray *currentPlayers;  // array of SBPerson

/**
 *  instance
 *
 *  @return instance
 */
+ (instancetype) share;


/**
 *  add one player with name
 *
 *  @param playerName <#playerName description#>
 */
- (void) addPlayer:(NSString *)playerName;

/**
 *  add one round game score
 *
 *  @param scores uid => score
 */
- (void) addOneRoundScore:(NSDictionary *)scores;

/**
 *  remove the person uid == uid
 *
 *  @param playerUid <#playerUid description#>
 */
- (void) removePlayer:(NSInteger)playerUid;

/**
 *  get score at round **
 *
 *  @param roundNumber <#roundNumber description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *) getScoreAtRound:(NSInteger)roundNumber;

/**
 *  get total game round
 *
 *  @return <#return value description#>
 */
- (NSInteger) getGamesRound;

/**
 *  总分
 *
 *  @return <#return value description#>
 */
- (NSArray *) getTotalGameScore;

/**
 *  remove game round
 *
 *  @param round <#round description#>
 */
- (void) removeGameRound:(NSInteger)round;





// test
- (void) addFackData1;

@end
