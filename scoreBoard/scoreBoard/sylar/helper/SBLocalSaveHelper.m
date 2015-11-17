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
#import "SBCommonDefine.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
# define kAutoSaveTimeInterval  (30)  // 5 min
# define kAutoSaveMaxNumber     (10)  // autoSave的最大保存的数量
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocalSaveHelper()

@property (nonatomic, strong) SBLocalSaveBlock blockSynchronizeData;

// 保存的数据
@property (nonatomic, strong) NSString *savePath;  // 保存路径，到文件夹的名字，请检查文件夹是否存在


// 保存的数据的index
/**
 *  all of   @{time0: time0, description: description, key:key, location: 上海人民广场,  persons:@[ @{uid: uid, name: name, score: totalScore} * 4 ]}
 */
@property (nonatomic, strong) NSMutableArray *allData;  // 所有保存的index array of NSDictionary
@property (nonatomic, strong) NSString *allDataPathPlist;  // index.plist 的path


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

- (BOOL) saveLocalData:(NSDictionary *)data persons:(NSArray *)persons
{
    BOOL save_data_success = NO;
    BOOL save_plist_success = NO;
    
    NSString *key = [data objectForKey:kSBSaveDataKey];
    NSString *description = [data objectForKey:kSBSaveDataDescription];
    NSString *location = [data objectForKey:kSBSaveDataLocation];
    
    // save data
    NSData *json_data = [persons JSONData];
    NSString *path = [NSString stringWithFormat:@"%@/%@", _savePath, key];
    save_data_success = [[NSFileManager defaultManager] createFileAtPath:path contents:json_data attributes:nil];
    
    // save to plist
    if (save_data_success)
    {
        NSDictionary *one_plist_dict = [self getPlistWithDescription:description key:key location:location];
        [_allData insertObject:one_plist_dict atIndex:0];
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

- (NSDictionary *) getPlistWithDescription:(NSString *)description key:(NSString *)key location:(NSString *)location
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
    
    NSDictionary *rt = @{kSBSaveDataKey: key,
                         kSBSaveDataDescription: description,
                         kSBSaveDataTime0: [NSString stringWithFormat:@"%f", time0],
                         kSBSaveDataLocation: location,
                         @"persons": all_persons};
    
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
        NSDictionary *auto_save_dict = [self getPlistWithDescription:@"auto save" key:@"auto save" location:@""];
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

- (void)synchronizeWithData:(NSArray *)models block:(SBLocalSaveBlock)block
{
    _blockSynchronizeData = block;
    
    // 先同步plist
    [_allData removeAllObjects];
    for (SBLocalSaveModel *each_model in models)
    {
        NSDictionary *each_dict = [each_model toDictionary];
        [_allData addObject:each_dict];
    }
    BOOL save_plist_success = [self saveAllDataPlist];
    
    if (save_plist_success)
    {
        // 把其他NSFileManager的文件删掉
        NSArray *all_file_name = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_savePath error:nil];
        if (all_file_name.count > 0)
        {
            BOOL no_error = YES;
            for (NSString *each_file_name in all_file_name)
            {
                BOOL file_exist = [self checkFileInPlist:each_file_name];
                NSLog(@"file - %@ - %d", each_file_name, file_exist);
                if (file_exist == NO)
                {
                    BOOL remove_success = [self deleteFile:each_file_name];
                    if (remove_success == NO)
                    {
                        no_error = NO;
                        break;
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_blockSynchronizeData)
                {
                    _blockSynchronizeData(no_error);
                }
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_blockSynchronizeData)
                {
                    _blockSynchronizeData(NO);
                }
            });
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
         if (_blockSynchronizeData)
         {
             _blockSynchronizeData(NO);
         }
        });
    }
}

/**
 *  判断这个文件是否在synchronize的时候需要保留
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
- (BOOL) checkFileInPlist:(NSString *)name
{
    BOOL rt = NO;
    for (NSDictionary *each_dict in _allData)
    {
        NSString *each_name = [each_dict objectForKey:@"key"];
        if ([each_name isEqualToString:name])
        {
            rt = YES;
            break;
        }
    }
    return rt;
}

- (BOOL)deleteFile:(NSString *)fileName
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", _savePath, fileName];
    BOOL rt = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    NSLog(@"remove = %d", rt);
    return rt;
}

@end
