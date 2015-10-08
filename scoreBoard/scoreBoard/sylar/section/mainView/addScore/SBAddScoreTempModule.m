//
//  SBAddScoreTempModule.m
//  scoreBoard
//
//  Created by sylar on 15/10/8.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddScoreTempModule.h"
#import "SBData.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreTempModule()

/**
 *  uid => score
 */
@property (nonatomic, strong) NSMutableDictionary *currentScore;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddScoreTempModule

+ (instancetype) share
{
    static SBAddScoreTempModule* inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBAddScoreTempModule alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _currentScore = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) resetCurrentData
{
    [_currentScore removeAllObjects];
}

- (void) setWithData:(NSString *)uid score:(NSString *)score
{
    if (score.length > 0)
    {
        [_currentScore setObject:score forKey:uid];
    }
    else
    {
        [_currentScore removeObjectForKey:uid];
    }
    
    NSInteger key_count = _currentScore.allKeys.count;
    NSInteger total_player_count = [SBData share].currentPlayers.count;
    
    if (key_count == 1)
    {
        // win
        NSString *win_uid = [_currentScore.allKeys lastObject];
        [self showWinWithUid:win_uid];
    }
    else if (key_count + 1 == total_player_count)
    {
        // last
        NSString *last_uid = uid;
        for (SBPerson *each_person in [SBData share].currentPlayers)
        {
            NSString *each_uid = [NSString stringWithFormat:@"%ld", each_person.uid];
            if ([_currentScore.allKeys containsObject:each_uid] == NO)
            {
                last_uid = each_uid;
                break;
            }
        }
        [self showLasWithUid:last_uid];
    }
    else
    {
        [self showNothing];
    }
    
}

- (void) showWinWithUid:(NSString *)uid
{
    NSDictionary *user_info = @{kSBAddScoreNotificationButtonDictionaryKeyUid: uid, kSBAddScoreNotificationButtonDictionaryKeyType: [NSString stringWithFormat:@"%ld", sb_add_score_notification_type_show_win]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationButtonName object:nil userInfo:user_info];
}

- (void) showLasWithUid:(NSString *)uid
{
    NSDictionary *user_info = @{kSBAddScoreNotificationButtonDictionaryKeyUid: uid, kSBAddScoreNotificationButtonDictionaryKeyType: [NSString stringWithFormat:@"%ld", sb_add_score_notification_type_show_last]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationButtonName object:nil userInfo:user_info];
}

- (void) showNothing
{
    NSDictionary *user_info = @{kSBAddScoreNotificationButtonDictionaryKeyUid: @"-1", kSBAddScoreNotificationButtonDictionaryKeyType: [NSString stringWithFormat:@"%ld", sb_add_score_notification_type_show_win]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationButtonName object:nil userInfo:user_info];
}

@end
