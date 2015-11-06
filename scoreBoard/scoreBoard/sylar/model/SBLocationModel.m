//
//  SBLocationModel.m
//  scoreBoard
//
//  Created by sylar on 15/11/5.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBLocationModel.h"

@implementation SBLocationModel

- (id) initWithLocation:(NSString *)location address:(NSString *)address distance:(NSString *)distance
{
    self = [super init];
    if (self)
    {
        _location = location;
        _address = address;
        _distance = [NSString stringWithFormat:@"%@米", distance];
    }
    return self;
}


@end
