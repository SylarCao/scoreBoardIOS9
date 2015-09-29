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
    _mainViewScoreBkgColor1 = RGBCOLOR(0, 200, 0);
    _mainViewScoreBkgColor2 = RGBCOLOR(0, 243, 0);
    _mainViewScoreColor = [UIColor blackColor];
    
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
}





@end
