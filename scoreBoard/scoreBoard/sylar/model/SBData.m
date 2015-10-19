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
#import "SBLocalSaveHelper.h"
#import "SBHelper.h"
#import "SBLocalSaveModel.h"
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
    }
    return self;
}

- (void) clearAllData
{
    [_currentPlayers removeAllObjects];
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

- (void) removeGameRound:(NSInteger)round
{
    NSInteger game_count = [self getGamesRound];
    if (game_count > round)
    {
        for (SBPerson *each_person in _currentPlayers)
        {
            [each_person removeScoreAtRound:round];
        }
    }
}

- (BOOL) saveScore:(NSString *)key
{
    BOOL rt = [self saveScore:key withDescription:@"无"];
    return rt;
}

- (BOOL) saveScore:(NSString *)key withDescription:(NSString *)description
{
    NSMutableArray *save_data = [[NSMutableArray alloc] init];
    for (SBPerson *each_person in _currentPlayers)
    {
        NSDictionary *each_dict = [each_person toDictionary];
        [save_data addObject:each_dict];
    }
    NSString *key_with_time = [NSString stringWithFormat:@"%@_%ld", key, (NSInteger)[[SBHelper share] getTime0]];
    BOOL rt = [[SBLocalSaveHelper share] saveLocalData:save_data withKey:key_with_time description:description];
    return rt;
}

- (void) revertWithKey:(NSString *)key
{
    [_currentPlayers removeAllObjects];
    NSArray *persons = [[SBLocalSaveHelper share] getLocalDataWithKey:key];
    for (NSDictionary *each_person in persons)
    {
        SBPerson *person = [[SBPerson alloc] initWithDictionary:each_person];
        [_currentPlayers addObject:person];
    }
}

#pragma mark - test
- (void) addFackData1
{
    [self addPlayer:@"player1"];
    [self addPlayer:@"player2"];
    [self addPlayer:@"player3"];
    [self addPlayer:@"player4"];
    
    
//    [self player1Win:20];
    
    [self randonScore:50];
}

- (void) player1Win:(NSInteger)winCount
{
    for (int i=1; i<winCount; i++)
    {
        NSInteger score = i%4+1;
        [self addFakeScore:score winnerUid:@"2"];
    }
}

- (void) randonScore:(NSInteger)gameCount
{
    for (int i=0; i<gameCount; i++)
    {
        NSInteger win_score = arc4random()%5+1;
        NSInteger win_uid = arc4random()%4+1;
        NSString *aa = [NSString stringWithFormat:@"%ld", win_uid];
        [self addFakeScore:win_score winnerUid:aa];
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

- (NSArray *) getPlistModels
{
    NSMutableArray *rt = [[NSMutableArray alloc] init];
    
    // other save plist
    NSArray *arr_dict = [[SBLocalSaveHelper share] getAllPlistDictionary];
    for (NSDictionary *each_dict in arr_dict)
    {
        SBLocalSaveModel *each_model = [[SBLocalSaveModel alloc] initWithDictionary:each_dict];
        [rt insertObject:each_model atIndex:0];
    }
    
//    // plist
//    NSDictionary *auto_save_dict = [[SBLocalSaveHelper share] getAutoPlistDictionary];
//    SBLocalSaveModel *auto_save_model = [[SBLocalSaveModel alloc] initWithDictionary:auto_save_dict];
//    [rt insertObject:auto_save_model atIndex:0];
    
    return rt;
}

- (NSArray *) getAutoSavePlistModels
{
    NSMutableArray *rt = [[NSMutableArray alloc] init];
    
    // array of NSDictionary
    NSArray *arr_auto_save = [[SBLocalSaveHelper share] getAutoSavePlist];
    for (NSDictionary *each_dict in arr_auto_save)
    {
        SBLocalSaveModel *aModel = [[SBLocalSaveModel alloc] initWithDictionary:each_dict];
        [rt addObject:aModel];
    }
    return rt;
}


@end
