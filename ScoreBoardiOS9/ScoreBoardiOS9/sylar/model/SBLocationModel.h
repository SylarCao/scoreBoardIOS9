//
//  SBLocationModel.h
//  scoreBoard
//
//  Created by sylar on 15/11/5.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBLocationModel : NSObject

@property (nonatomic, strong) NSString *location;   // 人民公园
@property (nonatomic, strong) NSString *address;    // 西藏南路 1000 号
@property (nonatomic, strong) NSString *distance;   // 200米


/**
 *  init
 *
 *  @param location <#location description#>
 *  @param address  <#address description#>
 *  @param distance 一个NSString类型的数字
 *
 *  @return <#return value description#>
 */
- (id) initWithLocation:(NSString *)location address:(NSString *)address distance:(NSString *)distance;

@end
