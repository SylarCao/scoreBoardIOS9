//
//  SBCommonDefine.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBCommonDefine.h"

@implementation SBCommonDefine

+ (instancetype) share
{
    static SBCommonDefine *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBCommonDefine alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        [self setInitialValue];
    }
    return self;
}

- (void) setInitialValue
{
    _mainViewLineNumberBkgColor = RGBCOLOR(244, 244, 244);
    _mainViewLineNumberColor = [UIColor blackColor];
    _mainViewScoreBkgColor1 = RGBCOLOR(14, 197, 5);
    _mainViewScoreBkgColor2 = RGBCOLOR(76, 243, 68);
    _mainViewScoreColor = [UIColor blackColor];
}





@end
