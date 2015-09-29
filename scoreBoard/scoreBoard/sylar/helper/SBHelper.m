//
//  SBHelper.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHelper()

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
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

- (void) greenButton:(UIButton *)btn
{
    // background color
    [btn setBackgroundImage:[UIImage imageNamed:@"img_green"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"img_green_HL"] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // border
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 10;
    btn.layer.masksToBounds = YES;
}

- (UIColor *) getRandomColor
{
    NSInteger r = arc4random()%250;
    NSInteger g = arc4random()%250;
    NSInteger b = arc4random()%250;
    
    UIColor *rt = [UIColor colorWithRed:r/255.9 green:g/255.9 blue:b/255.9 alpha:1];
    return rt;
}

@end
