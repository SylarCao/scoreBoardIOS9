//
//  SBTouchID.h
//  scoreBoard
//
//  Created by sylar on 15/11/17.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef void (^SBTouchIDSuccess)();
typedef void (^SBTouchIDFailure)();
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBTouchID : NSObject

/**
 *  instance
 *
 *  @return <#return value description#>
 */
+ (instancetype)share;

/**
 *  授权指纹
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void) authorizeWithTouchID:(SBTouchIDSuccess)success failure:(SBTouchIDFailure)failure;

@end
