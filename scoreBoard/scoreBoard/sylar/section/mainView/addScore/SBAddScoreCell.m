//
//  SBAddScoreCell.m
//  scoreBoard
//
//  Created by sylar on 15/9/30.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddScoreCell.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreCell()
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbNameWidth;
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UITextField *inputTextField;
@property (nonatomic, weak) IBOutlet UIButton *btnAutoCalculate;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddScoreCell

- (void)awakeFromNib {
    CGFloat f1 = self.contentView.frame.size.width/2 - 50;
    _lbNameWidth.constant = f1;
}

- (void) setWithName:(NSString *)name
{
    _name.text = name;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    return YES;
}

@end
