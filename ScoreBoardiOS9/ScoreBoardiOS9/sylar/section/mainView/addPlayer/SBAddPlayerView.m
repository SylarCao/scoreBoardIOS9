//
//  SBAddPlayerView.m
//  scoreBoard
//
//  Created by sylar on 15/9/28.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddPlayerView.h"
#import "SBHelper.h"
#import "LewPopupViewController.h"
#import "UITextField+Shake.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
static NSString *st_draftName = nil;
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddPlayerView()
<UITextFieldDelegate, LewPopupViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIButton *btnOK;
@property (nonatomic, assign) NSInteger moveUpDistance;
@property (nonatomic, assign) BOOL resignSaveName;    // if resign, save the draft name

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddPlayerView

+ (instancetype) getOneFromNib
{
    UINib *nib = [UINib nibWithNibName:@"SBAddPlayerView" bundle:nil];
    SBAddPlayerView *rt = [[nib instantiateWithOwner:nil options:nil] lastObject];
    return rt;
}

- (void) awakeFromNib
{
    [[SBHelper share] greenButton:_btnOK];
    self.backgroundColor = [UIColor lightGrayColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    _moveUpDistance = 75;
    _textField.text = st_draftName.copy;
    _resignSaveName = YES;
}

- (IBAction)btnOK:(id)sender
{
    NSString *name = _textField.text;
    if (name.length > 0)
    {
        _resignSaveName = NO;
        if ([_delegate respondsToSelector:@selector(SBAddPlayerViewDidTapOK:)])
        {
            [_delegate performSelector:@selector(SBAddPlayerViewDidTapOK:) withObject:name];
        }
    }
    else
    {
        [_textField shake];
    }
}

- (void) selfMoveUp
{
    [UIView animateWithDuration:kSBAnimationTimeDefault animations:^{
        CGPoint pos_now = self.center;
        pos_now.y = pos_now.y - _moveUpDistance;
        self.center = pos_now;
    }];
    
}

- (void) selfMoveDown
{
    [UIView animateWithDuration:kSBAnimationTimeDefault animations:^{
        CGPoint pos_now = self.center;
        pos_now.y = pos_now.y + _moveUpDistance;
        self.center = pos_now;
    }];
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(SBAddPlayerViewTextFieldDidBecomeActive)])
    {
        [_delegate performSelector:@selector(SBAddPlayerViewTextFieldDidBecomeActive)];
    }
    [self selfMoveUp];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(SBAddPlayerViewTextFieldDidResignActive)])
    {
        [_delegate performSelector:@selector(SBAddPlayerViewTextFieldDidResignActive)];
    }
    
    [self selfMoveDown];
}


#pragma mark - LewPopupViewControllerDelegate
- (void) LewPopupViewControllerTryDismiss:(BOOL)allowDismiss
{
    if ([_textField isFirstResponder])
    {
        [_textField resignFirstResponder];
    }
    
    if (_resignSaveName)
    {
        st_draftName = _textField.text;
    }
    else
    {
        st_draftName = nil;
    }
}

@end
