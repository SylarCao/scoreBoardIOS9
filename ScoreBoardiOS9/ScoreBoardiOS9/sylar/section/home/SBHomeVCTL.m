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
#import "SBHistoryVCTL.h"

// test
#import "SBData.h"
#import "SBHelper.h"
#import "JSONKit.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHomeVCTL ()

@property (nonatomic, weak) IBOutlet UIButton *btnViewHistory;
@property (nonatomic, weak) IBOutlet UIButton *btnRestart;
@property (nonatomic, weak) IBOutlet UIButton *btnContinue;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHomeVCTL

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setWithStatusBarColor];
    
    [[SBHelper share] greenButton:_btnContinue];
    [[SBHelper share] greenButton:_btnRestart];
    [[SBHelper share] greenButton:_btnViewHistory];
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
    [[SBData share] clearAllData];
    SBMainVCTL *mm = [[SBMainVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:mm animated:YES];
}

- (IBAction)btnContinue:(id)sender
{
    SBMainVCTL *mm = [[SBMainVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:mm animated:YES];
}

- (IBAction)btnViewHistory:(id)sender
{
    SBHistoryVCTL *his_vctl = [[SBHistoryVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:his_vctl animated:YES];
}

- (IBAction)btn1:(id)sender
{
    [[SBData share] addFackData1];
}

@end
