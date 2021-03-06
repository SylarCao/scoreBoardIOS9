//
//  SBAddPlayerVCTL.h
//  scoreBoard
//
//  Created by sylar on 15/9/28.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "SBBasicVCTL.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SBAddPlayerVCTLDelegate <NSObject>

@optional
- (void) SBAddPlayerVCTLDidTapOK;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddPlayerVCTL : SBBasicVCTL

@property (nonatomic, weak) id<SBAddPlayerVCTLDelegate> delegate;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////