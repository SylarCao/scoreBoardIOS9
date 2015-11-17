//
//  SBLocalSaveModel.m
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBLocalSaveModel.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBLocalModelPerson

- (NSDictionary *)toDictionary
{
    NSDictionary *rt = [[NSDictionary alloc] initWithObjectsAndKeys:
                        _uid, @"uid",
                        _name, @"name",
                        _totalScore, @"score",
                        nil];
    return rt;
}

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBLocalSaveModel

- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _time0 = [[dict objectForKey:@"time0"] integerValue];
        _descriptionContent = [dict objectForKey:@"description"];
        _key = [dict objectForKey:@"key"];
        _persons = [[NSMutableArray alloc] init];
        _location = [dict objectForKey:@"location"];
        for (NSDictionary *each_dict in [dict objectForKey:@"persons"])
        {
            SBLocalModelPerson *each_person = [[SBLocalModelPerson alloc] init];
            each_person.uid = [each_dict objectForKey:@"uid"];;
            each_person.name = [each_dict objectForKey:@"name"];;
            each_person.totalScore = [each_dict objectForKey:@"score"];
            [_persons addObject: each_person];
        }
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableArray *persons = [[NSMutableArray alloc] init];
    for (SBLocalModelPerson *each_person in _persons)
    {
        NSDictionary *each_person_dict = [each_person toDictionary];
        [persons addObject:each_person_dict];
    }
    NSDictionary *rt = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSString stringWithFormat:@"%ld", _time0], @"time0",
                        _descriptionContent, @"description",
                        _key, @"key",
                        persons, @"persons",
                        _location, @"location",
                        nil];
    return rt;
}

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////