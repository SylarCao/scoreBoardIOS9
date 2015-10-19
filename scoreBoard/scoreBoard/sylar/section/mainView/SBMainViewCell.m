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
    _lineNumberView.textColor = kSBMainViewLineNumberColor;
    
    _stackViewSubViews = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTripleTap)];
    tap3.numberOfTapsRequired = 3;
    [self.contentView addGestureRecognizer:tap3];
}


- (void) gestureTripleTap
{
    NSLog(@"tap 3");
    if ([_delegate respondsToSelector:@selector(SBMainViewCell:didTripleTapIndex:)])
    {
        NSInteger index = [_lineNumberView.text integerValue];
        [_delegate SBMainViewCell:self didTripleTapIndex:index-1];
    }
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
        text_color = [UIColor whiteColor];
    }
    if ([roundNumber isEqualToString:@"总"])
    {
        text_color = kSBMainViewTotalScoreColor;
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
        while (_stackView.arrangedSubviews.count > 0) {
            UIView *one_arrange_view = [_stackView.arrangedSubviews lastObject];
            [one_arrange_view removeFromSuperview];
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
