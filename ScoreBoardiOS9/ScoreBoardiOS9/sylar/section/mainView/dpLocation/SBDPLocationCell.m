//
//  SBDPLocationCell.m
//  scoreBoard
//
//  Created by sylar on 15/11/4.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBDPLocationCell.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBDPLocationCell()


@property (nonatomic, weak) IBOutlet UILabel *lbTitle;
@property (nonatomic, weak) IBOutlet UILabel *lbContent;
@property (nonatomic, weak) IBOutlet UILabel *lbDistance;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBDPLocationCell

- (void) setWithName:(NSString *)name address:(NSString *)address distance:(NSString *)distance
{
    _lbTitle.text = name;
    _lbContent.text = address;
    _lbDistance.text = distance;
}



@end
