//
//  SBMainViewCell.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBMainViewCell.h"
#import "SBCommonDefine.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewCell()


@property (nonatomic, weak) IBOutlet UILabel *lineNumberView;
@property (nonatomic, weak) IBOutlet UIStackView *stackView;
@property (nonatomic, strong) NSMutableArray *stackViewSubViews;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineNumberWidth;
@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainViewCell

- (void)awakeFromNib {
    // Initialization code
    
    // line number
    _lineNumberWidth.constant = kSBMainViewLineNumberWidth;
    _lineNumberView.backgroundColor = kSBMainViewLineNumberBKGColor;
    
    _stackViewSubViews = [[NSMutableArray alloc] init];
}


- (void) cellUpdateWithScores:(NSArray *)score roundNumber:(NSString *)roundNumber
{
    // round number
    _lineNumberView.text = roundNumber;
    
    // color - check round score == 0
    UIColor *text_color = kSBMainViewScoreColor;
    NSInteger zero_score = 0;
    for (NSString *each_score in score)
    {
        zero_score = zero_score + [each_score integerValue];
    }
    if (zero_score != 0)
    {
        text_color = [UIColor redColor];
    }
    
    // score
    NSInteger score_count = [score count];
    
    if (score_count == _stackView.arrangedSubviews.count)
    {
        // same count
        for (int i=0; i<score_count; i++)
        {
            NSString *score_i = [score objectAtIndex:i];
            UILabel *label_i = [_stackViewSubViews objectAtIndex:i];
            label_i.text = score_i;
            label_i.textColor = text_color;
        }
    }
    else
    {
        // remove all first
        for (UIView *each_subview in _stackViewSubViews)
        {
            [_stackView removeArrangedSubview:each_subview];
        }
        [_stackViewSubViews removeAllObjects];
        
        // add subview
        for (int i=0; i<score_count; i++)
        {
            NSString *each_score = [score objectAtIndex:i];
            UILabel *each_label = [[UILabel alloc] init];
            each_label.text = each_score;
            each_label.textColor = text_color;
            each_label.backgroundColor = kSBMainVIewScoreBkgColor12(i);
            each_label.textAlignment = NSTextAlignmentCenter;
            [_stackView addArrangedSubview:each_label];
            [_stackViewSubViews addObject:each_label];
        }
    }
    
   
}

- (void) setWithTotalScore:(NSArray *)totalScore
{
    [self cellUpdateWithScores:totalScore roundNumber:@"总"];
}


@end
