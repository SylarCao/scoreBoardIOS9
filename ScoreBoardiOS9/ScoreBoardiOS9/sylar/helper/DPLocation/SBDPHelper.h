//
//  SBDPHelper.h
//  scoreBoard
//
//  Created by sylar on 15/11/5.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import "SBLocationHelper.h"
#import "SBCategory.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *  <#Description#>
 *
 *  @param success  <#success description#>
 *  @param location array of SBLocationModel
 *  @param hasMore  <#hasMore description#>
 */
typedef void (^SBDPGetLocationBlock)(BOOL success, NSArray *location, BOOL hasMore);

////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBDPHelper : NSObject

/**
 *  instance
 *
 *  @return <#return value description#>
 */
+ (instancetype) share;

/**
 *  refresh page = 1
 *
 *  @param block <#block description#>
 */
- (void) refreshLocationData:(SBDPGetLocationBlock)block;

/**
 *  request more
 *
 *  @param block <#block description#>
 */
- (void) requestMoreLocationData:(SBDPGetLocationBlock)block;

/**
 *  大众点评最多返回40个，就一下子全部请求
 *
 *  @param block <#block description#>
 */
- (void) request40Data:(SBDPGetLocationBlock)block;



@end
////////////////////////////////////////////////////////////////////////////////////////////////////////