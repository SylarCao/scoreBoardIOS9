//
//  SBPerson.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBPerson : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *score;

/**
 *  init
 *
 *  @param uid        uid
 *  @param playerName playerName
 *
 *  @return id
 */
- (id) initWithPlayerUid:(NSInteger)uid playerNmae:(NSString *)playerName;

/**
 *  calculate total score
 *
 *  @return <#return value description#>
 */
- (NSInteger) getTotalScore;

/**
 *  <#Description#>
 *
 *  @param round <#round description#>
 *
 *  @return <#return value description#>
 */
- (NSString *) getScoreAtRound:(NSInteger)round;

@end
