//
//  SBData.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBGame.h"

@interface SBData : NSObject

@property (nonatomic, strong) NSMutableArray *currentPlayers;  // array of SBPerson
@property (nonatomic, strong) NSMutableArray *games;   // array of SBGame

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
 *  <#Description#>
 *
 *  @param scores   uid => score (see SBGame.h)
 *  @param gameType <#gameType description#>
 */
- (void) addGameWithScore:(NSDictionary *)scores type:(SBGameScoreType)gameType;





@end
