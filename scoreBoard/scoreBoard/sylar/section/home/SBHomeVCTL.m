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
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHomeVCTL ()

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHomeVCTL

- (void)viewDidLoad {
    
    [super viewDidLoad];
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
