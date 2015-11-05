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

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////