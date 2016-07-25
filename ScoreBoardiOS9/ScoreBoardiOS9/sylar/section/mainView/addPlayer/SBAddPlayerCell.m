//
//  SBAddPlayerCell.m
//  scoreBoard
//
//  Created by sylar on 15/9/28.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddPlayerCell.h"
#import "MGSwipeButton.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddPlayerCell()

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, assign) NSInteger personUid;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddPlayerCell

+ (NSString *) getCellId
{
    NSString *rt = @"SBAddPlayerCell_id";
    return rt;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setInitialValue];
}

- (void) setInitialValue
{
    MGSwipeButton *btn_delete = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]];
    [btn_delete addTarget:self action:@selector(btnDelete) forControlEvents:UIControlEventTouchUpInside];
    self.rightButtons = @[btn_delete];
    self.rightSwipeSettings.transition = MGSwipeTransitionStatic;
}

- (void) setWithName:(NSString *)name uid:(NSInteger)personUid
{
    _name.text = name;
    _personUid = personUid;
}

- (void) btnDelete
{
    if ([_myDelegate respondsToSelector:@selector(SBAddPlayerCell:didTapDelete:)])
    {
        [_myDelegate SBAddPlayerCell:self didTapDelete:_personUid];
    }
}

@end
