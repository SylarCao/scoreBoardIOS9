//
//  SBLocalSaveHelper.m
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBLocalSaveHelper.h"
#import "JSONKit.h"
#import "SBData.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
# define kAutoSaveTimeInterval  (30)  // 5 min
# define kAutoSaveMaxNumber     (10)  // autoSave的最大保存的数量
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocalSaveHelper()

// 保存的数据
@property (nonatomic, strong) NSString *savePath;  // 保存路径，到文件夹的名字，请检查文件夹是否存在


// 保存的数据的index
/**
 *  all of   @{time0: time0, description: description, key:key, persons:@[ @{uid: uid, name: name, score: totalScore} * 4 ]}
 */
@property (nonatomic, strong) NSMutableArray *allData;  // 所有保存的index array of NSDictionary
@property (nonatomic, strong) NSString *allDataPathPlist;  // ...plist


// 保存到 NSUserDefaults 里的数据
/*
  time0 => last save time
  autoSave => [ 和上边的index里一样 ]
 
 
*/

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBLocalSaveHelper

+ (instancetype) share
{
    static SBLocalSaveHelper *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBLocalSaveHelper alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _savePath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), @"dataSavePath"];
        [self checkDirectoryExist];
        _allDataPathPlist = [NSString stringWithFormat:@"%@/Documents/index.plist", NSHomeDirectory()];
        
        _allData = [[NSMutableArray alloc] initWithContentsOfFile:_allDataPathPlist];
        if (_allData == nil)
        {
            _allData = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void) checkDirectoryExist
{
    BOOL directory_exist = [[NSFileManager defaultManager] fileExistsAtPath:_savePath];
    if (directory_exist == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:_savePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (BOOL) saveLocalData:(NSArray *)persons withKey:(NSString *)key description:(NSString *)description
{
    BOOL save_data_success = NO;
    BOOL save_plist_success = NO;
    // save data
    NSData *data = [persons JSONData];
    NSString *path = [NSString stringWithFormat:@"%@/%@", _savePath, key];
    save_data_success = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    
    // save to plist
    if (save_data_success)
    {
        NSDictionary *one_plist_dict = [self getPlistWithDescription:description key:key];
        [_allData addObject:one_plist_dict];
        save_plist_success = [self saveAllDataPlist];
    }
    BOOL rt = save_data_success && save_plist_success;
    return rt;
}

- (id) getLocalDataWithKey:(NSString *)key
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", _savePath, key];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    id rt = [data objectFromJSONData];
    return rt;
}

- (NSDictionary *) getPlistWithDescription:(NSString *)description key:(NSString *)key
{
    NSTimeInterval time0 = [NSDate timeIntervalSinceReferenceDate];
    
    // person
    NSMutableArray *all_persons = [[NSMutableArray alloc] init];
    for (SBPerson *each_person in [SBData share].currentPlayers)
    {
        NSString *uid = [NSString stringWithFormat:@"%ld", each_person.uid];
        NSString *name = each_person.name;
        NSString *total_score = [NSString stringWithFormat:@"%ld", [each_person getTotalScore]];
        NSDictionary *each_dict = @{@"uid": uid, @"name": name, @"score": total_score};
        [all_persons addObject:each_dict];
    }
    
    NSDictionary *rt = @{@"key": key, @"description": description, @"time0": [NSString stringWithFormat:@"%f", time0], @"persons": all_persons};
    
    return rt;
}

- (BOOL) saveAllDataPlist
{
    BOOL rt = [_allData writeToFile:_allDataPathPlist atomically:YES];
    return rt;
}

- (void) autoSaveOnEnterBackground
{
    NSUserDefaults *user_default = [NSUserDefaults standardUserDefaults];
    NSTimeInterval last_save_time0 = [[user_default objectForKey:@"time0"] integerValue];
    NSTimeInterval time0_now = [NSDate timeIntervalSinceReferenceDate];
    
    if (time0_now - last_save_time0 > kAutoSaveTimeInterval)
    {
        // only save 5 minute later
        NSDictionary *auto_save_dict = [self getPlistWithDescription:@"auto save" key:@"auto save"];
        NSMutableArray *auto_save_array = [[user_default objectForKey:@"autoSave"] mutableCopy];
        if (auto_save_array == nil)
        {
            auto_save_array = [[NSMutableArray alloc] init];
        }
        else if (auto_save_array.count > 10)
        {
            [auto_save_array removeLastObject];
        }
        [auto_save_array addObject:auto_save_dict];
        [user_default setObject:auto_save_array forKey:@"autoSave"];
        [user_default setObject:[NSString stringWithFormat:@"%f", time0_now] forKey:@"time0"];
        [user_default synchronize];
    }
}
- (NSArray *) getAutoSavePlist
{
    NSArray *rt = [[NSUserDefaults standardUserDefaults] objectForKey:@"autoSave"];
    return rt;
}

- (NSArray *) getAllPlistDictionary
{
    return _allData;
}

@end
