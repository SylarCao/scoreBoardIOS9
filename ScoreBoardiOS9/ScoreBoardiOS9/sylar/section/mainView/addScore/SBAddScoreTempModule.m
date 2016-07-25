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
        NSString *last_uid = [self getLastUid:uid];
        [self showLasWithUid:last_uid];
    }
    else
    {
        [self showNothing];
    }
}

- (NSString *) getLastUid:(NSString *)defaultUid
{
    NSString *rt = defaultUid;
    for (SBPerson *each_person in [SBData share].currentPlayers)
    {
        NSString *each_uid = [NSString stringWithFormat:@"%ld", each_person.uid];
        if ([_currentScore.allKeys containsObject:each_uid] == NO)
        {
            rt = each_uid;
            break;
        }
    }
    return rt;
}

- (void) showWinWithUid:(NSString *)uid  // button
{
    NSDictionary *user_info = @{kSBAddScoreNotificationButtonDictionaryKeyUid: uid, kSBAddScoreNotificationButtonDictionaryKeyType: [NSString stringWithFormat:@"%ld", sb_add_score_notification_type_show_win]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationButtonName object:nil userInfo:user_info];
}

- (void) showLasWithUid:(NSString *)uid  // button
{
    NSDictionary *user_info = @{kSBAddScoreNotificationButtonDictionaryKeyUid: uid, kSBAddScoreNotificationButtonDictionaryKeyType: [NSString stringWithFormat:@"%ld", sb_add_score_notification_type_show_last]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationButtonName object:nil userInfo:user_info];
}

- (void) showNothing  // button
{
    NSDictionary *user_info = @{kSBAddScoreNotificationButtonDictionaryKeyUid: @"-1", kSBAddScoreNotificationButtonDictionaryKeyType: [NSString stringWithFormat:@"%ld", sb_add_score_notification_type_show_win]};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationButtonName object:nil userInfo:user_info];
}

- (void) showScore:(NSString *)score uid:(NSString *)uid  // text field
{
    NSDictionary *user_info = @{kSBAddScoreNotificationAutoCalculateDictionaryKeyUid: uid, kSBAddScoreNotificationAutoCalculateDictionaryKeyScore: score};
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationAutoCalculateName object:nil userInfo:user_info];
}

- (void) calculateWin
{
    NSString *score = [[_currentScore allValues] lastObject];
    NSInteger win_uid = [[[_currentScore allKeys] lastObject] integerValue];
    NSString *other_score = [NSString stringWithFormat:@"%ld", -[score integerValue]];
    for (SBPerson *each_person in [SBData share].currentPlayers)
    {
        if (each_person.uid != win_uid)
        {
            // other people score
            NSString *the_uid = [NSString stringWithFormat:@"%ld", each_person.uid];
            [self showScore:other_score uid:the_uid];
            [_currentScore setObject:other_score forKey:the_uid];
        }
        else
        {
            // modify the winner score
            NSInteger total_person = [[SBData share].currentPlayers count];
            NSInteger win_score = [score integerValue] * (total_person - 1);
            NSString *str_win_uid = [NSString stringWithFormat:@"%ld", win_uid];
            NSString *str_win_score = [NSString stringWithFormat:@"%ld", win_score];
            [self showScore:str_win_score uid:str_win_uid];
            [_currentScore setObject:str_win_score forKey:str_win_uid];
        }
    }
    [self showNothing];
}

- (void) calculateLast
{
    NSString *last_uid = [self getLastUid:nil];
    NSInteger all_other_score = 0;
    for (NSString *each_score in _currentScore.allValues)
    {
        all_other_score = all_other_score + [each_score integerValue];
    }
    NSString *last_score = [NSString stringWithFormat:@"%ld", -all_other_score];
    [self showScore:last_score uid:last_uid];
    [_currentScore setObject:last_score forKey:last_uid];
    [self showNothing];
}

- (NSDictionary *)getAddScore
{
    return _currentScore;
}










@end
