//
//  SBBasicVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/9/24.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBBasicVCTL.h"
#import "MBProgressHUD.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBBasicVCTL ()


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBBasicVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void) showHudWithContent:(NSString *)content
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 20;
    hud.labelText = content;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}



@end
