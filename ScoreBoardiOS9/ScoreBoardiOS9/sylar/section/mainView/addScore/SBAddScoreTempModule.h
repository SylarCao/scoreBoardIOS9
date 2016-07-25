//
//  SBAddScoreTempModule.h
//  scoreBoard
//
//  Created by sylar on 15/10/8.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
# define kSBAddScoreNotificationButtonName                         @"kSBAddScoreNotificationButtonName"     // name, hide or show button
# define kSBAddScoreNotificationButtonDictionaryKeyType            @"kSBAddScoreNotificationButtonDictionaryKeyType"
# define kSBAddScoreNotificationButtonDictionaryKeyUid             @"kSBAddScoreNotificationButtonDictionaryKeyUid"
# define kSBAddScoreNotificationAutoCalculateName                  @"kSBAddScoreNotificationAutoCalculateName"     // name, auto show score in textfield
# define kSBAddScoreNotificationAutoCalculateDictionaryKeyUid      @"kSBAddScoreNotificationAutoCalculateDictionaryKeyUid"
# define kSBAddScoreNotificationAutoCalculateDictionaryKeyScore    @"kSBAddScoreNotificationAutoCalculateDictionaryKeyScore"
# define kSBAddScoreNotificationKeyboardName                       @"kSBAddScoreNotificationKeyboardName"  // name, hide keyboard
////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(NSUInteger, SBAddScoreNotificationType) {
    sb_add_score_notification_type_none = 0,   // nothing input => show win/last with no uid (never use)
    sb_add_score_notification_type_show_win,   // first one input
    sb_add_score_notification_type_show_last,  // only one empty
};
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreTempModule : NSObject

/**
 *  instance
 *
 *  @return <#return value description#>
 */
+ (instancetype) share;

/**
 *  clear all data
 */
- (void) resetCurrentData;

/**
 *  type one score
 *
 *  @param uid   <#uid description#>
 *  @param score <#score description#>
 */
- (void) setWithData:(NSString *)uid score:(NSString *)score;

/**
 *  press the win button
 */
- (void) calculateWin;


/**
 *  press the last button
 */
- (void) calculateLast;

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)getAddScore;




@end
////////////////////////////////////////////////////////////////////////////////////////////////////////