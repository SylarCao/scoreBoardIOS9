//
//  SBLocalSaveHelper.h
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import "SBLocalSaveModel.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
typedef void (^SBLocalSaveBlock)(BOOL success);
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocalSaveHelper : NSObject

/**
 *  instance 
 *
 *  @return <#return value description#>
 */
+ (instancetype) share;

/**
 *  save data to local, use NSFileManager
 *  save to plist
 *
 *  @param data      key, description, location
 *  @param persons <#persons description#>
 *
 *  @return <#return value description#>
 */
- (BOOL) saveLocalData:(NSDictionary *)data persons:(NSArray *)persons;

/**
 *  get data from local
 *
 *  @param key <#key description#>
 *
 *  @return dict or array
 */
- (id) getLocalDataWithKey:(NSString *)key;

/**
 *  auto save when press home button
 */
- (void) autoSaveOnEnterBackground;

/**
 *  get autoSaveOnEnterBackground NSArray
 *
 *  @return <#return value description#>
 */
- (NSArray *) getAutoSavePlist;

/**
 *  all the data save in plist
 *
 *  @return array of NSDictionary
 */
- (NSArray *) getAllPlistDictionary;

/**
 *  修改本地保存的东西
 *
 *  @param models array of SBLocalSaveModel
 *  @param block  <#block description#>
 */
- (void)synchronizeWithData:(NSArray *)models block:(SBLocalSaveBlock)block;

@end
