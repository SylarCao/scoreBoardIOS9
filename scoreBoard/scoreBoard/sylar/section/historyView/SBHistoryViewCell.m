//
//  SBHistoryViewCell.m
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBHistoryViewCell.h"
#import "SBLocalSaveModel.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHistoryViewCell()

@property (nonatomic, weak) IBOutlet UILabel *lbTime0;
@property (nonatomic, weak) IBOutlet UILabel *lbDescription;
@property (nonatomic, weak) IBOutlet UILabel *lbScroe;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHistoryViewCell

- (void)awakeFromNib {
    
    
}

- (void) setWithData:(SBLocalSaveModel *)data
{
    // date
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:data.time0];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd  HH:mm";
    NSString *date_content = [format stringFromDate:date];
    _lbTime0.text = date_content;
    
    // description
    _lbDescription.text = data.descriptionContent;
    
    // score
    NSString *score_content = @"";
    for (SBLocalModelPerson *each_person in data.persons)
    {
        NSString *name = each_person.name;
        NSString *score = each_person.totalScore;
        if (score_content.length > 1)
        {
            score_content = [NSString stringWithFormat:@"%@\n", score_content];
        }
        score_content = [NSString stringWithFormat:@"%@%@:   %@", score_content, name, score];
    }
    _lbScroe.text = score_content;
    
}


@end
