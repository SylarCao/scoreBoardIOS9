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

- (void) addOneRoundScore:(NSDictionary *)scores
{
    for (SBPerson *each_person in _currentPlayers)
    {
        NSString *uid = [NSString stringWithFormat:@"%ld", each_person.uid];
        NSString *score = [scores objectForKey:uid];
        if (score)
        {
            [each_person addScore:score];
        }
        else
        {
            [each_person addScore:@"0"];
        }
    }
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

- (NSInteger) getGamesRound
{
    SBPerson *last_person = [_currentPlayers lastObject];
    NSInteger rt = [last_person.score count];
    return rt;
}

- (NSArray *) getTotalGameScore
{
    NSMutableArray *rt = [[NSMutableArray alloc] init];
    for (SBPerson *each_person in _currentPlayers)
    {
        NSInteger each_total_score = [each_person getTotalScore];
        [rt addObject:[NSString stringWithFormat:@"%ld", each_total_score]];
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
    
    
    for (int i=1; i<10; i++)
    {
        NSInteger score = i%4+1;
        [self addFakeScore:score winnerUid:@"2"];
    }
}

- (void) addFakeScore:(NSInteger)winScore winnerUid:(NSString *)winnerUid
{
    NSMutableDictionary *add_scores = [[NSMutableDictionary alloc] init];
    for (SBPerson *each_person in _currentPlayers)
    {
        if (each_person.uid == [winnerUid integerValue])
        {
            NSString *winner_score = [NSString stringWithFormat:@"%ld", winScore*(_currentPlayers.count-1)];
            [add_scores setObject:winner_score forKey:winnerUid];
        }
        else
        {
            NSString *loser_score = [NSString stringWithFormat:@"%ld", -winScore];
            NSString *loser_uid = [NSString stringWithFormat:@"%ld", each_person.uid];
            [add_scores setObject:loser_score forKey:loser_uid];
        }
    }
    [self addOneRoundScore:add_scores];
}



@end
