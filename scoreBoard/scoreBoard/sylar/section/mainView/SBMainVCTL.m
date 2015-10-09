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
#import "SBAddPlayerVCTL.h"
#import "SBAddScoreVCTL.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainVCTL ()
<UITableViewDataSource, UITableViewDelegate,
SBMainViewHeaderDelegate,
SBAddPlayerVCTLDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_table registerNib:[UINib nibWithNibName:@"SBMainViewCell" bundle:nil] forCellReuseIdentifier:[SBMainViewCell getCellId]];
    [_table registerClass:[SBMainViewHeader class] forHeaderFooterViewReuseIdentifier:[SBMainViewHeader getHeaderId]];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = [[SBData share] getGamesRound] + 1;
    
    return rt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBMainViewCell *rt = [tableView dequeueReusableCellWithIdentifier:[SBMainViewCell getCellId] forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row < [[SBData share] getGamesRound])
    {
        NSArray *score = [[SBData share] getScoreAtRound:row];
        [rt cellUpdateWithScores:score roundNumber:[NSString stringWithFormat:@"%ld", row+1]];
    }
    else
    {
        // total score
        NSArray *total_score = [[SBData share] getTotalGameScore];
        [rt setWithTotalScore:total_score];
    }
    
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
    SBMainViewHeader *rt = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[SBMainViewHeader getHeaderId]];
    rt.delegate = self;
    [rt refresh];
    return rt;
}

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - SBAddPlayerVCTLDelegate
- (void) SBAddPlayerVCTLDidTapOK
{
    [_table reloadData];
}


#pragma mark - SBMainViewHeaderDelegate
- (void) SBMainViewHeaderDidLongpressAddBtn
{
    SBAddPlayerVCTL *add_palyer = [[SBAddPlayerVCTL alloc] initWithNibName:nil bundle:nil];
    add_palyer.delegate = self;
    [self.navigationController pushViewController:add_palyer animated:YES];
}

- (void) SBMainViewHeaderDidTapAddBtn
{
    SBAddScoreVCTL *add_score = [[SBAddScoreVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:add_score animated:YES];
}

@end
