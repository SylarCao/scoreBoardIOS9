//
//  SBDPLocationCell.h
//  scoreBoard
//
//  Created by sylar on 15/11/4.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBBasicTableViewCell.h"

@interface SBDPLocationCell : SBBasicTableViewCell


/**
 *  loaction info from dp
 *
 *  @param name    人民广场
 *  @param address 西藏路1000号
 */
- (void) setWithName:(NSString *)name address:(NSString *)address;



@end
