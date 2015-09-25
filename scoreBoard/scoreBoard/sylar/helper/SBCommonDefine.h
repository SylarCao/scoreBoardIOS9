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
# define kSBMainViewHeaderHeight       (50)

// main view color
# define kSBMainViewLineNumberBKGColor  ([SBCommonDefine share].mainViewLineNumberBkgColor)
# define kSBMainViewLineNumberColor     ([SBCommonDefine share].mainViewLineNumberColor)
# define kSBMainViewScoreBkgColor1      ([SBCommonDefine share].mainViewScoreBkgColor1)
# define kSBMainViewScoreBkgColor2      ([SBCommonDefine share].mainViewScoreBkgColor2)
# define kSBMainViewScoreColor          ([SBCommonDefine share].mainViewScoreColor)





////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBCommonDefine : NSObject

@property (nonatomic, strong) UIColor *mainViewLineNumberBkgColor;
@property (nonatomic, strong) UIColor *mainViewLineNumberColor;
@property (nonatomic, strong) UIColor *mainViewScoreBkgColor1;
@property (nonatomic, strong) UIColor *mainViewScoreBkgColor2;
@property (nonatomic, strong) UIColor *mainViewScoreColor;



+ (instancetype) share;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////