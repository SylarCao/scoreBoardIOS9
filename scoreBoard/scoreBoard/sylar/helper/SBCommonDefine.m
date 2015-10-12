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
    _mainViewLineNumberColor = [UIColor redColor];
    _mainViewScoreBkgColor1 = RGBCOLOR(0, 200, 0);
    _mainViewScoreBkgColor2 = RGBCOLOR(0, 243, 0);
    _mainViewScoreColor = [UIColor blackColor];
    
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (UIColor *) getBkgGreenColor12:(NSInteger)int12
{
    UIColor *rt = nil;
    if ((int12 % 2) == 0)
    {
        rt = [SBCommonDefine share].mainViewScoreBkgColor1;
    }
    else
    {
        rt = [SBCommonDefine share].mainViewScoreBkgColor2;
    }
    return rt;
}



@end
