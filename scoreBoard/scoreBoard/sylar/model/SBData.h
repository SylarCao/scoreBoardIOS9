//
//  SBData.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
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
 *  clear all data, init
 */
- (void) clearAllData;

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

/**
 *  save score to local
 *
 *  @param data key, 唯一， 不要重复, with time0
 *
 *  @return <#return value description#>
 */
- (BOOL) saveScoreWithDictionary:(NSDictionary *)data;
- (BOOL) saveScore:(NSString *)key;

/**
 *  查看历史版本
 *
 *  @param key key，with time0
 */
- (void) revertWithKey:(NSString *)key;

/**
 *  保存过的(不包括 autoSave)
 *
 *  @return array of SBLocalSaveModel
 */
- (NSArray *) getPlistModels;

/**
 *  auto save 的plist
 *
 *  @return array of SBLocalSaveModel
 */
- (NSArray *) getAutoSavePlistModels;


// test
- (void) addFackData1;

@end
