//
//  SBHomeVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/9/24.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBHomeVCTL.h"
#import "SBMainVCTL.h"
#import "SBCommonDefine.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHomeVCTL ()

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHomeVCTL

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setWithStatusBarColor];
}

- (void) setWithStatusBarColor
{
    /*******************
    instruction: http://stackoverflow.com/questions/19063365/how-to-change-the-status-bar-background-color-and-text-color-on-ios-7
    1) Set View controller-based status bar appearance to NO
    2) Set Status bar style to UIStatusBarStyleLightContent
    */
    
    UIView *ss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    ss.backgroundColor = kSBStatusBarBkgColor;
    [self.navigationController.view addSubview:ss];
}




- (IBAction)btnRestart:(id)sender
{
    SBMainVCTL *mm = [[SBMainVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:mm animated:YES];
}

- (IBAction)btnContinue:(id)sender
{
    
}



@end
