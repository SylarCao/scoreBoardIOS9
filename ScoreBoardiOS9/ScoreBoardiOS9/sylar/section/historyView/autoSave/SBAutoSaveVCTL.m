//
//  SBAutoSaveVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/10/16.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAutoSaveVCTL.h"
#import "SBAutoSaveCell.h"
#import "SBData.h"
#import "SBLocalSaveModel.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAutoSaveVCTL ()
<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *autoSaveData;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAutoSaveVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table
    [_tableView registerNib:[UINib nibWithNibName:@"SBHistoryViewCell" bundle:nil] forCellReuseIdentifier:[SBAutoSaveCell getCellId]];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.estimatedRowHeight = 40;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    // data
    _autoSaveData = [[SBData share] getAutoSavePlistModels];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"自动保存";
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillDisappear:animated];
}





#pragma mark  - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = [_autoSaveData count];
    return rt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBAutoSaveCell *rt = [tableView dequeueReusableCellWithIdentifier:[SBAutoSaveCell getCellId] forIndexPath:indexPath];
    [rt setWithData:[_autoSaveData objectAtIndex:indexPath.row]];
    return rt;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
