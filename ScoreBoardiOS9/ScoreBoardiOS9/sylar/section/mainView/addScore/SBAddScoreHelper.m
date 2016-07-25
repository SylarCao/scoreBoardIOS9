//
//  SBAddScoreHelper.m
//  scoreBoard
//
//  Created by sylar on 15/10/16.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddScoreHelper.h"
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreHelper()

@property (nonatomic, strong) UIButton *btnMinusIcon;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddScoreHelper

+ (instancetype) share
{
    static SBAddScoreHelper *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBAddScoreHelper alloc] init];
    });
    return inst;
}

- (void) showMinusIcon
{
    if (_btnMinusIcon == nil)
    {
        _btnMinusIcon = [self getMinusIconOnNumberKeyboard];
        [_btnMinusIcon addTarget:self action:@selector(btnMinusIconTap) forControlEvents:UIControlEventTouchUpInside];
    }
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:_btnMinusIcon];
}

- (void) hideMinusIcon
{
    [_btnMinusIcon removeFromSuperview];
}

- (UIButton *) getMinusIconOnNumberKeyboard
{
    UIButton *rt = [UIButton buttonWithType:UIButtonTypeCustom];
    UIColor *normal_bkg_color = [UIColor clearColor];
    UIColor *highlight_bkg_color = [UIColor whiteColor];
    [rt setBackgroundImage:[[SBHelper share] imageWithColor:normal_bkg_color] forState:UIControlStateNormal];
    [rt setBackgroundImage:[[SBHelper share] imageWithColor:highlight_bkg_color] forState:UIControlStateHighlighted];
    [rt setTitle:@"-" forState:UIControlStateNormal];
    [rt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rt.frame = CGRectMake(0, kScreenHeight-53, 122, 53);
    return rt;
}

- (void) btnMinusIconTap
{
    if ([_delegate respondsToSelector:@selector(SBAddScoreHelperDidTapMinus)])
    {
        [_delegate performSelector:@selector(SBAddScoreHelperDidTapMinus)];
    }
}


@end
