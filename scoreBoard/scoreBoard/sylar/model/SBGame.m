//
//  SBGame.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBGame.h"

@implementation SBGame

- (id) initWithScores:(NSDictionary *)scores type:(SBGameScoreType)type
{
    self = [super init];
    if (self)
    {
        _score = scores;
        _type = type;
        
    }
    return self;
}

- (NSInteger) getScoreForPlayer:(NSString *)uid
{
    NSString *score_string = [_score objectForKey:uid];
    NSInteger rt = [score_string integerValue];
    return rt;
}

@end
