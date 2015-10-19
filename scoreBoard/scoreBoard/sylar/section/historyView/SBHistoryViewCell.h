//
//  SBHistoryViewCell.h
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBBasicTableViewCell.h"
@class SBLocalSaveModel;

@interface SBHistoryViewCell : SBBasicTableViewCell


- (void) setWithData:(SBLocalSaveModel *)data;


@end
