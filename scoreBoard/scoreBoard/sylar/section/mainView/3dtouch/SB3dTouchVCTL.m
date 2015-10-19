//
//  SB3dTouchVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/10/14.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SB3dTouchVCTL.h"
#import "SBHelper.h"
#import "SBAddPlayerVCTL.h"

#import "SBMainVCTL.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SB3dTouchVCTL ()

@property (nonatomic, weak) IBOutlet UIButton *btnBack;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SB3dTouchVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[SBHelper share] greenButton:_btnBack];
}

- (NSArray *)previewActionItems
{
    UIPreviewAction *action_add_score = [UIPreviewAction actionWithTitle:@"添加分数" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([_delegate respondsToSelector:@selector(SB3dTouchVCTLTapAddScore)])
        {
            [_delegate performSelector:@selector(SB3dTouchVCTLTapAddScore)];
        }
    }];
    
    UIPreviewAction *action_add_player = [UIPreviewAction actionWithTitle:@"添加玩家" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([_delegate respondsToSelector:@selector(SB3dTouchVCTLTapAddPlayer)])
        {
            [_delegate performSelector:@selector(SB3dTouchVCTLTapAddPlayer)];
        }
    }];
    
    UIPreviewAction *action_save_score = [UIPreviewAction actionWithTitle:@"保存分数" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([_delegate respondsToSelector:@selector(SB3dTouchVCTLTapSaveScore)])
        {
            [_delegate performSelector:@selector(SB3dTouchVCTLTapSaveScore)];
        }
    }];
    
    UIPreviewAction *action_back = [UIPreviewAction actionWithTitle:@"返回" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([_delegate respondsToSelector:@selector(SB3dTouchVCTLTapBack)])
        {
            [_delegate performSelector:@selector(SB3dTouchVCTLTapBack)];
        }
    }];
    
    UIPreviewAction *action_add_other = [UIPreviewAction actionWithTitle:@"其他" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([_delegate respondsToSelector:@selector(SB3dTouchVCTLTapOther)])
        {
            [_delegate performSelector:@selector(SB3dTouchVCTLTapOther)];
        }
    }];
    
    NSArray *rt = @[action_add_score, action_add_player, action_save_score, action_back, action_add_other];
    return rt;
}

- (IBAction)btnBackDonw:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
