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


- (void) cellUpdateWithScores:(NSArray *)score
{
    NSInteger score_count = [score count];
    
    if (score_count == _stackView.arrangedSubviews.count)
    {
        // same count
        for (int i=0; i<score_count; i++)
        {
            NSString *score_i = [score objectAtIndex:i];
            UILabel *label_i = [_stackViewSubViews objectAtIndex:i];
            label_i.text = score_i;
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
        for (NSString *each_score in score)
        {
            UILabel *each_label = [[UILabel alloc] init];
            each_label.text = each_score;
            each_label.textColor = kSBMainViewScoreColor;
            each_label.backgroundColor = [UIColor redColor];
            each_label.textAlignment = NSTextAlignmentCenter;
            [_stackView addArrangedSubview:each_label];
            [_stackViewSubViews addObject:each_label];
        }
    }
}



@end
