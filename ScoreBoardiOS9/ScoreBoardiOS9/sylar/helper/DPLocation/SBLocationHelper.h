//
//  SBLocationHelper.h
//  scoreBoard
//
//  Created by sylar on 15/11/5.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef void (^SBLocationBlock)(BOOL success, CLLocationDegrees longitude, CLLocationDegrees latitude);

////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocationHelper : NSObject

/**
 *  instance
 *
 *  @return <#return value description#>
 */
+ (instancetype) share;

/**
 *  请求一次位置
 *
 *  @param block <#block description#>
 */
- (void) getOneLocationWithBlock:(SBLocationBlock)block;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////