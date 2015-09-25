//
//  SBHelper.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBHelper.h"

@implementation SBHelper

+ (instancetype) share
{
    static SBHelper *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBHelper alloc] init];
    });
    return inst;
}

@end
