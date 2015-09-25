//
//  SBMainVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBMainVCTL.h"
#import "SBData.h"
#import "SBMainViewCell.h"
#import "SBMainViewHeader.h"
#import "SBCommonDefine.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainVCTL ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;



@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_table registerNib:[UINib nibWithNibName:@"SBMainViewCell" bundle:nil] forCellReuseIdentifier:[SBMainViewCell getCellId]];
    [_table registerNib:[UINib nibWithNibName:@"SBMainViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:[SBMainViewHeader getHeaderId]];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBMainViewCell *rt = [tableView dequeueReusableCellWithIdentifier:[SBMainViewCell getCellId] forIndexPath:indexPath];
    
    
    return rt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rt = kSBMainViewCellHeight;
    return rt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat rt = kSBMainViewHeaderHeight;
    return rt;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *rt = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[SBMainViewHeader getHeaderId]];
    
    
    return rt;
}


@end
