//
//  SBBasicTableViewCell.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import "SBBasicTableViewCell.h"

@implementation SBBasicTableViewCell

+ (NSString *) getCellId
{
    NSString *rt = NSStringFromClass([self class]);
    return rt;
}

@end
