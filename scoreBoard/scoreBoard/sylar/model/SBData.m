//
//  SBData.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBData.h"
#import "SBPerson.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBData()


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBData

+ (instancetype) share
{
    static SBData *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBData alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _currentPlayers = [[NSMutableArray alloc] init];
        _games = [[NSMutableArray alloc] init];
        [self addFackData1];
    }
    return self;
}

- (void) addPlayer:(NSString *)playerName
{
    SBPerson *last_person = [_currentPlayers lastObject];
    NSInteger uid = last_person.uid;
    SBPerson *person = [[SBPerson alloc] initWithPlayerUid:(uid+1) playerNmae:playerName];
    [_currentPlayers addObject:person];
}

- (void) addGameWithScore:(NSDictionary *)scores type:(SBGameScoreType)gameType
{
    SBGame *game = [[SBGame alloc] initWithScores:scores type:gameType];
    [_games addObject:game];
}

- (NSInteger) getTotalGameScoreForPlayer:(NSInteger)uid
{
    NSInteger rt = 0;
    for (SBPerson *each_person in _currentPlayers)
    {
        if (each_person.uid == uid)
        {
            rt = [each_person getTotalScore];
            break;
        }
    }
    return rt;
}

- (void) removePlayer:(NSInteger)playerUid
{
    for (SBPerson *each_person in _currentPlayers)
    {
        if (each_person.uid == playerUid)
        {
            [_currentPlayers removeObject:each_person];
            break;
        }
    }
}

- (NSArray *) getScoreAtRound:(NSInteger)roundNumber
{
    NSMutableArray *rt = [[NSMutableArray alloc] init];
    for (SBPerson *each_person in _currentPlayers)
    {
        NSString *each_score = [each_person getScoreAtRound:roundNumber];
        [rt addObject:each_score];
    }
    return rt;
}

#pragma mark - test
- (void) addFackData1
{
    [self addPlayer:@"player1"];
    [self addPlayer:@"player2"];
    [self addPlayer:@"player3"];
    [self addPlayer:@"player4"];
}



@end
