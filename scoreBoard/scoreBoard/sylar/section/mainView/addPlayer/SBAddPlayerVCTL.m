//
//  SBAddPlayerVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/9/28.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBAddPlayerVCTL.h"
#import "SBAddPlayerCell.h"
#import "SBData.h"
#import "SBPerson.h"
#import "SBHelper.h"
#import "SBAddPlayerView.h"
#import "LewPopupViewController.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBAddPlayerVCTL ()
<UITableViewDataSource, UITableViewDelegate, SBAddPlayerCellDelegate, SBAddPlayerViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, weak) IBOutlet UIButton *btnAddPlayer;
@property (nonatomic, weak) IBOutlet UIButton *btnDone;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBAddPlayerVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table view
    [_table registerNib:[UINib nibWithNibName:@"SBAddPlayerCell" bundle:nil] forCellReuseIdentifier:[SBAddPlayerCell getCellId]];
    UIView* v1 = [[UIView alloc] init];
    _table.tableFooterView = v1;
    
    // button
    [[SBHelper share] greenButton:_btnAddPlayer];
    [[SBHelper share] greenButton:_btnDone];
}

- (IBAction)btnAddPlayer:(id)sender
{
    SBAddPlayerView *add_player_view = [SBAddPlayerView getOneFromNib];
    add_player_view.frame = CGRectMake(0, 0, 300, 150);
    self.lewDelegate = (id) add_player_view;
    add_player_view.delegate = self;
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeTopBottom;
    [self lew_presentPopupView:add_player_view animation:animation];
}

- (IBAction)btnDone:(id)sender
{
    if ([_delegate respondsToSelector:@selector(SBAddPlayerVCTLDidTapOK)])
    {
        [_delegate performSelector:@selector(SBAddPlayerVCTLDidTapOK)];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = [[SBData share].currentPlayers count];
    return rt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBAddPlayerCell *rt = [tableView dequeueReusableCellWithIdentifier:[SBAddPlayerCell getCellId] forIndexPath:indexPath];
    SBPerson *person = [[SBData share].currentPlayers objectAtIndex:indexPath.row];
    [rt setWithName:person.name uid:person.uid];
    rt.myDelegate = self;
    return rt;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - SBAddPlayerCellDelegate
- (void) SBAddPlayerCell:(SBAddPlayerCell *)cell didTapDelete:(NSInteger)personUid
{
    [[SBData share] removePlayer:personUid];
    
    // remove the cell
    NSIndexPath *index_path = [_table indexPathForCell:cell];
    [_table deleteRowsAtIndexPaths:@[index_path] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - SBAddPlayerViewDelegate
- (void) SBAddPlayerViewTextFieldDidBecomeActive
{
    self.lewAllowDismiss = NO;
}

- (void) SBAddPlayerViewTextFieldDidResignActive
{
    self.lewAllowDismiss = YES;
}

- (void) SBAddPlayerViewDidTapOK:(NSString *)name
{
    self.lewAllowDismiss = YES;
    [self lew_dismissPopupView];
    
    [[SBData share] addPlayer:name];
    [_table reloadData];
}


@end
