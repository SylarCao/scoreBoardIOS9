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
    }
    return self;
}

- (void) addPlayer:(NSString *)playerName
{
    NSInteger uid = [_currentPlayers count];
    SBPerson *person = [[SBPerson alloc] initWithPlayerUid:uid playerNmae:playerName];
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
    
    
    return rt;
}


@end
