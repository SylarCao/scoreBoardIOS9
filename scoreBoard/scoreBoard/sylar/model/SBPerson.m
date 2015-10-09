//
//  SBPerson.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBPerson.h"

@implementation SBPerson

- (id) initWithPlayerUid:(NSInteger)uid playerNmae:(NSString *)playerName
{
    self = [super init];
    if (self)
    {
        _uid = uid;
        _name = playerName;
        _score = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger) getTotalScore
{
    NSInteger rt = 0;
    for (NSString *each_score in _score)
    {
        rt = rt + [each_score integerValue];
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
    [_score addObject:score];
}

@end
