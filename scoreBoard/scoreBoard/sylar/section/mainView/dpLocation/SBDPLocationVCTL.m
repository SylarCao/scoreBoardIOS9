//
//  SBDPLocationVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/11/4.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBDPLocationVCTL.h"
#import "SBDPLocationCell.h"
#import "SBDPLocationCustomCell.h"
#import "MJRefresh.h"
#import "SBDPHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBDPLocationVCTL ()
<UITableViewDataSource, UITableViewDelegate, SBDPLocationCustomCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MJRefreshNormalHeader *header;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBDPLocationVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table view
    [_tableView registerNib:[UINib nibWithNibName:@"SBDPLocationCell" bundle:nil] forCellReuseIdentifier:[SBDPLocationCell getCellId]];
    [_tableView registerNib:[UINib nibWithNibName:@"SBDPLocationCustomCell" bundle:nil] forCellReuseIdentifier:[SBDPLocationCustomCell getCellId]];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    
    // refresh location
    
}




#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *rt = nil;
    NSInteger row = indexPath.row;
    if (row == 0)
    {
        // 自定义地点
        SBDPLocationCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:[SBDPLocationCustomCell getCellId] forIndexPath:indexPath];
        cell.delegate = self;
        
        rt = cell;
    }
    else
    {
        SBDPLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[SBDPLocationCell getCellId] forIndexPath:indexPath];
        
        rt = cell;
    }
    return rt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rt = 40;
    NSInteger row = indexPath.row;
    if (row > 0)
    {
        // 不是自定义cell
        rt = 70;
    }
    return rt;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < 4)
        [[SBDPHelper share] refreshLocationData:^(BOOL success, NSArray *location, BOOL hasMore) {
            NSLog(@"");
        }];
    else
    {
        [[SBDPHelper share] requestMoreLocationData:^(BOOL success, NSArray *location, BOOL hasMore) {
            NSLog(@"");
        }];
    }
}




#pragma mark - SBDPLocationCustomCellDelegate
- (void) SBDPLocationCustomCell:(SBDPLocationCustomCell *)cell didTapDone:(NSString *)location
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
