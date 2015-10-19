//
//  SBAddScoreCell.m
//  scoreBoard
//
//  Created by sylar on 15/9/30.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddScoreCell.h"
#import "SBPerson.h"
#import "SBAddScoreTempModule.h"
#import "SBAddScoreHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
# define kSBAddScoreCellKeyBoardDownNotification @"kSBAddScoreCellKeyBoardDownNotification"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreCell()
<UITextFieldDelegate, SBAddScoreHelperDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbNameWidth;
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UITextField *inputTextField;
@property (nonatomic, weak) IBOutlet UIButton *btnAutoCalculate;
@property (nonatomic, assign) SBAddScoreNotificationType btnCurrentType;
@property (nonatomic, strong) SBPerson *person;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddScoreCell

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    CGFloat f1 = self.contentView.frame.size.width/2 - 50;
    _lbNameWidth.constant = f1;
    _btnAutoCalculate.hidden = YES;
    
    // notification
    // hide show button
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationShowHideButton:) name:kSBAddScoreNotificationButtonName object:nil];
    // hide key board
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationTextfieldEndEditing) name:kSBAddScoreNotificationKeyboardName object:nil];
    // auto calculate
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationScoreAutoCalculate:) name:kSBAddScoreNotificationAutoCalculateName object:nil];
    
    // keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

    // tap
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCellGesture)];
    [self.contentView addGestureRecognizer:tap1];
}

- (void) setWithPerson:(SBPerson *)person
{
    _person = person;
    _name.text = person.name;
}

- (void) tapCellGesture
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSBAddScoreNotificationKeyboardName object:nil];
}

- (void) receiveNotificationShowHideButton:(NSNotification *)aNotification
{
    NSDictionary *dict = aNotification.userInfo;
    NSString *uid = [dict objectForKey:kSBAddScoreNotificationButtonDictionaryKeyUid];
    if ([uid integerValue] == _person.uid)
    {
        _btnAutoCalculate.hidden = NO;
        SBAddScoreNotificationType type = [[dict objectForKey:kSBAddScoreNotificationButtonDictionaryKeyType] integerValue];
        if (type == sb_add_score_notification_type_show_win)
        {
            _btnCurrentType = sb_add_score_notification_type_show_win;
            [_btnAutoCalculate setImage:[UIImage imageNamed:@"img_auto_calculate_win"] forState:UIControlStateNormal];
        }
        else if (type == sb_add_score_notification_type_show_last)
        {
            _btnCurrentType = sb_add_score_notification_type_show_last;
            [_btnAutoCalculate setImage:[UIImage imageNamed:@"img_auto_calculate_last"] forState:UIControlStateNormal];
        }
    }
    else
    {
        _btnCurrentType = sb_add_score_notification_type_none;
        _btnAutoCalculate.hidden = YES;
    }
}

- (void) receiveNotificationScoreAutoCalculate:(NSNotification *)aNotification
{
    NSDictionary *user_info = aNotification.userInfo;
    NSString *uid = [user_info objectForKey:kSBAddScoreNotificationAutoCalculateDictionaryKeyUid];
    if ([uid integerValue] == _person.uid)
    {
        NSString *score = [user_info objectForKey:kSBAddScoreNotificationAutoCalculateDictionaryKeyScore];
        _inputTextField.text = score;
    }
}

- (void) receiveNotificationTextfieldEndEditing
{
    if ([_inputTextField isFirstResponder])
    {
        [_inputTextField resignFirstResponder];
    }
}

- (IBAction)btnCalculate:(id)sender
{
    if (_btnCurrentType == sb_add_score_notification_type_show_win)
    {
        [[SBAddScoreTempModule share] calculateWin];
    }
    else
    {
        [[SBAddScoreTempModule share] calculateLast];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *text = textField.text;
    NSString *uid = [NSString stringWithFormat:@"%ld", _person.uid];
    
    [[SBAddScoreTempModule share] setWithData:uid score:text];
}

#pragma mark - keyboard && SBAddScoreHelperDelegate
- (void) keyBoardDidShow:(NSNotification *)aNotification
{
    BOOL first_responder = [_inputTextField isFirstResponder];
    if (first_responder)
    {
        [[SBAddScoreHelper share] showMinusIcon];
        [SBAddScoreHelper share].delegate = self;
    }
}

- (void) keyBoardWillHide:(NSNotification *)aNotification
{
    BOOL first_responder = [_inputTextField isFirstResponder];
    if (first_responder)
    {
        [[SBAddScoreHelper share] hideMinusIcon];
    }
}

- (void) SBAddScoreHelperDidTapMinus
{
    NSString *score_typed = _inputTextField.text;
    if (score_typed.length >= 1)
    {
        NSString *first_string = [score_typed substringToIndex:1];
        if ([first_string isEqualToString:@"-"])
        {
            _inputTextField.text = [score_typed substringFromIndex:1];
        }
        else
        {
            _inputTextField.text = [NSString stringWithFormat:@"-%@", score_typed];
        }
    }
    else
    {
        _inputTextField.text = @"-";
    }
}

@end
