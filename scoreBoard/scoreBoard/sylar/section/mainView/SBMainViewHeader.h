//
//  SBMainViewHeader.h
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SBMainViewHeaderDelegate <NSObject>

@optional
/**
 *  long press, navigate to add player
 */
- (void) SBMainViewHeaderDidLongpressAddBtn;

/**
 *  tap, navigate to add score
 */
- (void) SBMainViewHeaderDidTapAddBtn;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewHeader : UITableViewHeaderFooterView


@property (nonatomic, weak) id<SBMainViewHeaderDelegate> delegate;

/**
 *  get header id
 *
 *  @return <#return value description#>
 */
+ (NSString *) getHeaderId;

/**
 *  refresh data
 */
- (void) refresh;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
