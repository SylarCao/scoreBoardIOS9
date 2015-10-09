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
#import "SBAddScoreTempModule.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddScoreVCTL ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet UIButton *btnDone;
@property (nonatomic, weak) IBOutlet UIButton *btnCancel;
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
    
    // data model
    [[SBAddScoreTempModule share] resetCurrentData];
    
    // table
    [_table registerNib:[UINib nibWithNibName:@"SBAddScoreCell" bundle:nil] forCellReuseIdentifier:[SBAddScoreCell getCellId]];
    UIView *view_footer = [[UIView alloc] init];
    _table.tableFooterView = view_footer;
    
    // button
    [[SBHelper share] greenButton:_btnDone];
    [[SBHelper share] greenButton:_btnCancel];
    
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
    NSDictionary *the_score = [[SBAddScoreTempModule share] getAddScore];
    
    NSLog(@"add score = %@", the_score);
    
    NSInteger total_score = 0;
    for (NSString *each_score in the_score.allValues)
    {
        total_score = total_score + [each_score integerValue];
    }
    
    if (total_score == 0)
    {
        [self addScoreBack:the_score];
    }
    else
    {
        // not equal to Zero => show the action sheet
        UIAlertController *alert_vctl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *back_button = [UIAlertAction actionWithTitle:@"确认添加分数" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self addScoreBack:the_score];
        }];
        [alert_vctl addAction:back_button];
        UIAlertAction *cancel_button = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert_vctl addAction:cancel_button];
        [self presentViewController:alert_vctl animated:YES completion:nil];
    }
}

- (void) addScoreBack:(NSDictionary *)score
{
    [[SBData share] addOneRoundScore:score];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCancelTap:(id)sender
{
    UIAlertController *alert_vctl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *back_button = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert_vctl addAction:back_button];
    UIAlertAction *cancel_button = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert_vctl addAction:cancel_button];
    [self presentViewController:alert_vctl animated:YES completion:nil];
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
    SBPerson *person_i = [[SBData share].currentPlayers objectAtIndex:indexPath.row];
    [rt setWithPerson:person_i];
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









@end
