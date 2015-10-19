//
//  SB3dTouchVCTL.h
//  scoreBoard
//
//  Created by sylar on 15/10/14.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
#import "SBBasicVCTL.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SB3dTouchVCTLDelegate <NSObject>

@optional

- (void) SB3dTouchVCTLTapAddScore;

- (void) SB3dTouchVCTLTapAddPlayer;

- (void) SB3dTouchVCTLTapSaveScore;

- (void) SB3dTouchVCTLTapBack;

- (void) SB3dTouchVCTLTapOther;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SB3dTouchVCTL : SBBasicVCTL


@property (nonatomic, weak) id<SB3dTouchVCTLDelegate> delegate;

@end
