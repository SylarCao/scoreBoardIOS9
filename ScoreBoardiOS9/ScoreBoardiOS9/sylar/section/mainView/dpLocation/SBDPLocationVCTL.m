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
#import "SBDPLocationNoDataCell.h"
#import "MJRefresh.h"
#import "SBDPHelper.h"
#import "SBLocationModel.h"
#import "MJRefresh.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBDPLocationVCTL ()
<UITableViewDataSource, UITableViewDelegate, SBDPLocationCustomCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MJRefreshNormalHeader *header;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;

@property (nonatomic, strong) NSArray *data;  // array of SBLocationModel

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBDPLocationVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table view
    [_tableView registerNib:[UINib nibWithNibName:@"SBDPLocationCell" bundle:nil] forCellReuseIdentifier:[SBDPLocationCell getCellId]];
    [_tableView registerNib:[UINib nibWithNibName:@"SBDPLocationCustomCell" bundle:nil] forCellReuseIdentifier:[SBDPLocationCustomCell getCellId]];
    [_tableView registerNib:[UINib nibWithNibName:@"SBDPLocationNoDataCell" bundle:nil] forCellReuseIdentifier:[SBDPLocationNoDataCell getCellId]];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    // refresh location
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    _header.automaticallyChangeAlpha = YES;
    _header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.header = _header;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_tableView.header beginRefreshing];
}

- (void) pullDownRefresh
{
    [[SBDPHelper share] request40Data:^(BOOL success, NSArray *location, BOOL hasMore) {
        [_tableView.header endRefreshing];
        if (success)
        {
            _data = location;
            [_tableView reloadData];
        }
        else
        {
            [self showHudWithContent:@"请求失败"];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = 2;  // 第一个是 输入内容，第二个是没有数据
    NSInteger location_count = [_data count];
    if (location_count > 0)
    {
        rt = location_count + 1;
    }
    return rt;
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
        NSInteger location_count = [_data count];
        if (location_count == 0)
        {
            // 没有数据
            SBDPLocationNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:[SBDPLocationNoDataCell getCellId] forIndexPath:indexPath];
            rt = cell;
        }
        else
        {
            // 大众点评的数据cell
            SBDPLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[SBDPLocationCell getCellId] forIndexPath:indexPath];
            SBLocationModel *model = [_data objectAtIndex:row-1];
            [cell setWithName:model.location address:model.address distance:model.distance];
            rt = cell;
        }
    }
    return rt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rt = 40;  // 自己输入内容的 = 40
    NSInteger row = indexPath.row;
    if (row > 0)
    {
        NSInteger location_count = [_data count];
        if (location_count == 0)
        {
            // 没有数据
            rt = _tableView.frame.size.height - 40 - 20;  // 减去第一个cell和状态栏高度
        }
        else
        {
            // 大众点评的数据cell
            rt = 70;
        }
    }
    return rt;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    BOOL rt = YES;
    if (indexPath.row == 0)
    {
        rt = NO;
    }
    return rt;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_block)
    {
        NSInteger row = indexPath.row;
        SBLocationModel *model = [_data objectAtIndex:row-1];
        _block(YES, model.location);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SBDPLocationCustomCellDelegate
- (void) SBDPLocationCustomCell:(SBDPLocationCustomCell *)cell didTapDone:(NSString *)location
{
    if (_block)
    {
        _block (YES, location);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
