//
//  SBMainViewSaveDataView.m
//  scoreBoard
//
//  Created by sylar on 15/10/16.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBMainViewSaveDataView.h"
#import "LewPopupViewController.h"
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
# define kSBMainViewSaveDataViewBtnOKWidth (160)
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewSaveDataView()
<LewPopupViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *keyTextField;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIButton *btnOK;
@property (nonatomic, weak) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnOkWidth;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainViewSaveDataView


+ (instancetype) getOneFromNib
{
    static SBMainViewSaveDataView *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UINib *nib = [UINib nibWithNibName:@"SBMainViewSaveDataView" bundle:nil];
        inst = [[nib instantiateWithOwner:nil options:nil] lastObject];
    });
    return inst;
}

- (void) awakeFromNib
{
//    [[SBHelper share] greenButton:_btnOK];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    _descriptionTextView.layer.cornerRadius = 3;
    _descriptionTextView.layer.borderColor = [UIColor grayColor].CGColor;
    _descriptionTextView.layer.borderWidth = 0.5;
    
    [[SBHelper share] greenButton:_btnCancel];
    [[SBHelper share] greenButton:_btnOK];
    _btnOkWidth.constant = kSBMainViewSaveDataViewBtnOKWidth;
}

- (IBAction)btnOkTap:(id)sender
{
    if ([_delegate respondsToSelector:@selector(SBMainViewSaveDataViewDidTapOKWithKey:description:)])
    {
        NSString *key = _keyTextField.text;
        NSString *des = _descriptionTextView.text;
        [_delegate performSelector:@selector(SBMainViewSaveDataViewDidTapOKWithKey:description:) withObject:key withObject:des];
    }
}

- (IBAction)btnCancelTap:(id)sender
{
    if ([_delegate respondsToSelector:@selector(SBMainViewSaveDataViewDidTapCancel)])
    {
        [_delegate performSelector:@selector(SBMainViewSaveDataViewDidTapCancel)];
    }
}


#pragma mark - LewPopupViewControllerDelegate
- (void) LewPopupViewControllerTryDismiss:(BOOL)allowDismiss
{
    if ([_keyTextField isFirstResponder])
    {
        [_keyTextField resignFirstResponder];
    }
    else if ([_descriptionTextView isFirstResponder])
    {
        [_descriptionTextView resignFirstResponder];
    }
}


@end
