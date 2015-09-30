//
//  SBAddScoreVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/9/28.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddScoreVCTL.h"
#import "SBAddScoreCell.h"
#import "SBData.h"
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreVCTL ()
<UITableViewDataSource, UITableViewDelegate,
SBAddScoreCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableUpDistance;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat lastCellHeight;
@property (nonatomic, assign) NSInteger current_player_count;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddScoreVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // table
    [_table registerNib:[UINib nibWithNibName:@"SBAddScoreCell" bundle:nil] forCellReuseIdentifier:[SBAddScoreCell getCellId]];
    UIView *view_footer = [[UIView alloc] init];
    _table.tableFooterView = view_footer;
    
    // button
    [[SBHelper share] greenButton:_btnDone];
    
    // calculate cell height
    _cellHeight = 80;
    _current_player_count = [[SBData share].currentPlayers count];
    
    if (_current_player_count <= 4)
    {
        _table.scrollEnabled = NO;
        _tableHeight.constant = _cellHeight*4;
    }
    else
    {
        _tableUpDistance.constant = 40;
        _tableHeight.constant = kScreenHeight - 40 - 100;
        _cellHeight = 60;
    }
}

- (IBAction)btnDoneTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = _current_player_count;
    return rt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBAddScoreCell *rt = [tableView dequeueReusableCellWithIdentifier:[SBAddScoreCell getCellId] forIndexPath:indexPath];
    rt.delegate = self;
    SBPerson *person_i = [[SBData share].currentPlayers objectAtIndex:indexPath.row];
    [rt setWithName:person_i.name];

    return rt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rt = _cellHeight;
    return rt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark - SBAddScoreCellDelegate
- (void) SBAddScoreCell:(SBAddScoreCell *)cell didChangeInputText:(NSString *)text
{
    
}

- (void) SBAddScoreCell:(SBAddScoreCell *)cell didTapAutoCalculate:(BOOL)win
{
    
    
    
    
}







@end
