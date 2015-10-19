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
@property (nonatomic, strong) NSMutableArray *score;  // array of string

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
 *  <#Description#>
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
- (id) initWithDictionary:(NSDictionary *)dict;

/**
 *  convert self to dictionary
 *
 *  @return <#return value description#>
 */
- (NSDictionary *) toDictionary;

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

/**
 *  add one score
 *
 *  @param score <#score description#>
 */
- (void) addScore:(NSString *)score;

/**
 *  <#Description#>
 *
 *  @param round <#round description#>
 */
- (void) removeScoreAtRound:(NSInteger)round;





@end
