//
//  SBLocalSaveModel.h
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocalModelPerson : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *totalScore;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocalSaveModel : NSObject

@property (nonatomic, assign) NSInteger time0;
@property (nonatomic, strong) NSString *descriptionContent;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSMutableArray *persons;  // array of SBLocalModelPerson

- (id) initWithDictionary:(NSDictionary *)dict;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////