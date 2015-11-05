//
//  SBMainViewSaveDataView.h
//  scoreBoard
//
//  Created by sylar on 15/10/16.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 *  用大众点评的location
 *
 *  @param success  没选择地点或者失败，返回NO
 *  @param location <#location description#>
 */
typedef void (^SBGetDPLocation)(BOOL success, NSString *location);
////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol SBMainViewSaveDataViewDelegate <NSObject>

@optional
- (void) SBMainViewSaveDataViewDidTapOKWithKey:(NSString *)key description:(NSString *)description location:(NSString *)location;
- (void) SBMainViewSaveDataViewDidTapCancel;
- (void) SBMainViewSaveDataViewDidTapLocationWithBlock:(SBGetDPLocation)block;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewSaveDataView : UIView

@property (nonatomic, weak) id<SBMainViewSaveDataViewDelegate> delegate;

/**
 *  get an instance 
 *
 *  @return <#return value description#>
 */
+ (instancetype) getOneFromNib;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////