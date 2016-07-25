//
//  SBDPLocationCustomCell.m
//  scoreBoard
//
//  Created by sylar on 15/11/4.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBDPLocationCustomCell.h"
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBDPLocationCustomCell()

@property (nonatomic, weak) IBOutlet UITextField *inputField;
@property (nonatomic, weak) IBOutlet UIButton *btnDone;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBDPLocationCustomCell

- (void)awakeFromNib {
    [[SBHelper share] greenButton:_btnDone];
}

- (IBAction)btnDone:(id)sender
{
    NSString *location = _inputField.text;
    if (location.length > 1)
    {
        if ([_delegate respondsToSelector:@selector(SBDPLocationCustomCell:didTapDone:)])
        {
            [_delegate SBDPLocationCustomCell:self didTapDone:location];
        }
    }
}


@end
