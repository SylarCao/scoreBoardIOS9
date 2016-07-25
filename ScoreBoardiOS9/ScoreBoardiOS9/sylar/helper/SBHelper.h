//
//  SBHelper.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBCommonDefine.h"

@interface SBHelper : NSObject

/**
 *  instance
 *
 *  @return instance
 */
+ (instancetype) share;

/**
 *  set the button to the green type
 *
 *  @param btn the target button
 */
- (void) greenButton:(UIButton *)btn;

/**
 *  get random color
 *
 *  @return <#return value description#>
 */
- (UIColor *) getRandomColor;

/**
 *  get reference time from 2001/1/1 8:0:0
 *
 *  @return <#return value description#>
 */
- (CGFloat) getTime0;

/**
 *  get image from color
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end
