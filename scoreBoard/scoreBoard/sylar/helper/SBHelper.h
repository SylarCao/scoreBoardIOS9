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

@end
