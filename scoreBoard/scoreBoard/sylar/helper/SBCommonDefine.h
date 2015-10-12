//
//  SBCommonDefine.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
#define RGBCOLOR(r,g,b)       ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1])
#define RGBACOLOR(r,g,b,a)    ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])
////////////////////////////////////////////////////////////////////////////////////////////////////////



# define kSBMainViewLineNumberWidth    (40)
# define kSBMainViewCellHeight         (30)
# define kSBMainViewHeaderHeight       (33)

// common
# define kSBStatusBarBkgColor     (RGBCOLOR(232, 232, 232))
# define kSBAnimationTimeDefault  (0.2)
# define kScreenWidth             ([SBCommonDefine share].screenWidth)
# define kScreenHeight            ([SBCommonDefine share].screenHeight)


// main view color
# define kSBMainViewLineNumberBKGColor  kSBMainViewScoreBkgColor2
# define kSBMainViewLineNumberColor     ([SBCommonDefine share].mainViewLineNumberColor)    // black color
# define kSBMainViewScoreBkgColor1      ([SBCommonDefine share].mainViewScoreBkgColor1)    // green 1
# define kSBMainViewScoreBkgColor2      ([SBCommonDefine share].mainViewScoreBkgColor2)    // green 2
# define kSBMainViewScoreColor          ([SBCommonDefine share].mainViewScoreColor)          // black color

# define kSBMainVIewScoreBkgColor12(color12)  ([[SBCommonDefine share] getBkgGreenColor12:(color12)])  // color1 or color2

// add score view controller
# define kSBAddScoreVCTLMinCellHeight  (40)






////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBCommonDefine : NSObject

@property (nonatomic, strong) UIColor *mainViewLineNumberBkgColor;
@property (nonatomic, strong) UIColor *mainViewLineNumberColor;
@property (nonatomic, strong) UIColor *mainViewScoreBkgColor1;
@property (nonatomic, strong) UIColor *mainViewScoreBkgColor2;
@property (nonatomic, strong) UIColor *mainViewScoreColor;

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;


+ (instancetype) share;

/**
 *  return green1 or green2 color
 *
 *  @param int12 <#int12 description#>
 *
 *  @return <#return value description#>
 */
- (UIColor *) getBkgGreenColor12:(NSInteger)int12;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////