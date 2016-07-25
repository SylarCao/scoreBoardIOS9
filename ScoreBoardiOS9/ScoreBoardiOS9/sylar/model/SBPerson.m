//
//  SBPerson.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBPerson.h"
#import "SBData.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBPerson()

@property (nonatomic, assign) BOOL totalScoreChange;
@property (nonatomic, assign) NSInteger totalScore;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBPerson

- (id) initWithPlayerUid:(NSInteger)uid playerNmae:(NSString *)playerName
{
    NSInteger game_round = [[SBData share] getGamesRound];
    self = [self initWithPlayerUid:uid playerNmae:playerName zeroScoreCount:game_round];
    return self;
}

- (id) initWithPlayerUid:(NSInteger)uid playerNmae:(NSString *)playerName zeroScoreCount:(NSInteger)zeroScoreCount
{
    self = [super init];
    if (self)
    {
        _uid = uid;
        _name = playerName;
        _score = [[NSMutableArray alloc] init];
        _totalScoreChange = YES;
        _totalScore = 0;
        for (int i=0; i<zeroScoreCount; i++)
        {
            [_score addObject:@"0"];
        }
    }
    return self;
}

- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _uid = [[dict objectForKey:@"uid"] integerValue];
        _name = [dict objectForKey:@"name"];
        _score = [[dict objectForKey:@"score"] mutableCopy];
        _totalScoreChange = YES;
        _totalScore = 0;
    }
    return self;
}

- (NSDictionary *) toDictionary
{
    NSDictionary *rt = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSString stringWithFormat:@"%ld", _uid], @"uid",
                        _name, @"name",
                        _score, @"score",
                        nil];
    return rt;
}

- (NSInteger) getTotalScore
{
    NSInteger rt = 0;
    if (_totalScoreChange == NO)
    {
        rt = _totalScore;
    }
    else
    {
        for (NSString *each_score in _score)
        {
            rt = rt + [each_score integerValue];
        }
        _totalScore = rt;
        _totalScoreChange = NO;
    }
    return rt;
}

- (NSString *) getScoreAtRound:(NSInteger)round
{
    NSString *rt = @"999";
    if (round < _score.count)
    {
        rt = [_score objectAtIndex:round];
    }
    return rt;
}

- (void) addScore:(NSString *)score
{
//    // score可能是 NSTaggedPointerString 会报错
      // 使用了新的jsonKit不知道会不会出问题
//    NSString *ss = [NSString stringWithString:score];
    _totalScoreChange = YES;
    [_score addObject:score];
}

- (void) removeScoreAtRound:(NSInteger)round
{
    [_score removeObjectAtIndex:round];
}

@end
