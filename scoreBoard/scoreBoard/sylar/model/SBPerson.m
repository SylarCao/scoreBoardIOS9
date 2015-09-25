//
//  SBPerson.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBPerson.h"

@implementation SBPerson

- (id) initWithPlayerUid:(NSInteger)uid playerNmae:(NSString *)playerName
{
    self = [super init];
    if (self)
    {
        _uid = uid;
        _name = playerName;
    }
    return self;
}

@end
