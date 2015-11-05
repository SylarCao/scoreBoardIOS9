//
//  SBLocalSaveHelper.h
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

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

///**
// *  save data to local, use NSFileManager
// *  save to plist
// *
// *  @param persons     <#persons description#>
// *  @param key         key to save  唯一 不要重复
// *  @param description plist的描述
// *
// *  @return <#return value description#>
// */
//- (BOOL) saveLocalData:(NSArray *)persons withKey:(NSString *)key description:(NSString *)description;

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

@end
