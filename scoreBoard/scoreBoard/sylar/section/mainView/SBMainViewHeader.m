//
//  SBMainViewHeader.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBMainViewHeader.h"
#import "SBCommonDefine.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewHeader()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (nonatomic, weak) IBOutlet UIStackView *stackView;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainViewHeader

+ (NSString *) getHeaderId
{
    NSString *rt = @"SBMainViewHeader_header_id";
    return rt;
}

- (void) awakeFromNib
{
    _leftSpace.constant = kSBMainViewLineNumberWidth;
}





@end
