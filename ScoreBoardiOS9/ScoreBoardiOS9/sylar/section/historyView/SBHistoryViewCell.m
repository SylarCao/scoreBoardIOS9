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
#import "MGSwipeButton.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHistoryViewCell()

@property (nonatomic, weak) IBOutlet UILabel *lbTime0;
@property (nonatomic, weak) IBOutlet UILabel *lbDescription;
@property (nonatomic, weak) IBOutlet UILabel *lbScroe;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHistoryViewCell

+ (NSString *) getCellId
{
    NSString *rt = NSStringFromClass([self class]);
    return rt;
}

- (void) setWithDeleteButton
{
    MGSwipeButton *b1 = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        if ([_delegateTap respondsToSelector:@selector(SBHistoryViewCellDidTapDelete:)])
        {
            [_delegateTap performSelector:@selector(SBHistoryViewCellDidTapDelete:) withObject:self];
        }
        return YES;
    }];
    [b1 setPadding:20];
    self.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    self.rightButtons = @[b1];
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
//    _lbScroe.text = score_content;
    
    // 地址  暂时就放在score里，最上边
    NSString *location  = data.location;
    if (location.length > 1)
    {
        score_content = [NSString stringWithFormat:@"地址:%@\n%@", location, score_content];
    }
    _lbScroe.text = score_content;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction fromPoint:(CGPoint) point
{
    BOOL rt = YES;
    if ([_delegateTap respondsToSelector:@selector(SBHistoryViewCellShouldSwipe:)])
    {
        rt = [_delegateTap performSelector:@selector(SBHistoryViewCellShouldSwipe:) withObject:self];
    }
    return rt;
}

@end
