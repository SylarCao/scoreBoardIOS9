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
#import "SB3dTouchVCTL.h"
#import "SBMainViewSaveDataView.h"
#import "LewPopupViewController.h"
#import "SBDPLocationVCTL.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainVCTL ()
<UITableViewDataSource, UITableViewDelegate,
SBMainViewHeaderDelegate,
SBAddPlayerVCTLDelegate,
SBMainViewCellDelegate,
UIViewControllerPreviewingDelegate,
SB3dTouchVCTLDelegate,
SBMainViewSaveDataViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *table;


@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_table registerNib:[UINib nibWithNibName:@"SBMainViewCell" bundle:nil] forCellReuseIdentifier:[SBMainViewCell getCellId]];
    [_table registerClass:[SBMainViewHeader class] forHeaderFooterViewReuseIdentifier:[SBMainViewHeader getHeaderId]];
    
    // 3d touch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_table reloadData];
    
    // 太慢了
    [SBMainViewSaveDataView getOneFromNib];
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
    rt.delegate = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark - SBMainViewCellDelegate
- (void) SBMainViewCell:(SBMainViewCell *)cell didTripleTapIndex:(NSInteger)index
{
    UIAlertController *alert_vctl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *back_button = [UIAlertAction actionWithTitle:@"偷偷删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[SBData share] removeGameRound:index];
        [_table reloadData];
    }];
    [alert_vctl addAction:back_button];
    UIAlertAction *cancel_button = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert_vctl addAction:cancel_button];
    [self presentViewController:alert_vctl animated:YES completion:nil];
}

#pragma mark - UIViewControllerPreviewingDelegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0)
{
    SB3dTouchVCTL *d3 = [[SB3dTouchVCTL alloc] initWithNibName:nil bundle:nil];
    d3.preferredContentSize = CGSizeMake(200, 100);
    d3.delegate = self;
    return d3;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0)
{
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}

#pragma mark - SB3dTouchVCTLDelegate
- (void) SB3dTouchVCTLTapAddScore
{
    SBAddScoreVCTL *add_score_vctl = [[SBAddScoreVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:add_score_vctl animated:YES];
}

- (void) SB3dTouchVCTLTapAddPlayer
{
    SBAddPlayerVCTL *add_player_vctl = [[SBAddPlayerVCTL alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:add_player_vctl animated:YES];
}

- (void) SB3dTouchVCTLTapSaveScore
{
    // pop up to type description
    SBMainViewSaveDataView *save_data_view = [SBMainViewSaveDataView getOneFromNib];
    save_data_view.frame = CGRectMake(0, 0, 300, 340);
    self.lewDelegate = (id) save_data_view;
    save_data_view.delegate = self;
    LewPopupViewAnimationSlide *animation = [[LewPopupViewAnimationSlide alloc]init];
    animation.type = LewPopupViewAnimationSlideTypeTopBottom;
    [self lew_presentPopupView:save_data_view animation:animation];
}

- (void) SB3dTouchVCTLTapBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) SB3dTouchVCTLTapOther
{
    
}


#pragma mark - SBMainViewSaveDataViewDelegate
- (void) SBMainViewSaveDataViewDidTapOKWithKey:(NSString *)key description:(NSString *)description location:(NSString *)location
{
    [self lew_dismissPopupView:YES];
    if (key.length < 1)
    {
        key = @"no_key";
    }
    NSDictionary *dict = @{kSBSaveDataKey: key, kSBSaveDataDescription: description, kSBSaveDataLocation: location};
    BOOL save_success = [[SBData share] saveScoreWithDictionary:dict];
    if (save_success)
    {
        [self showHudWithContent:@"保存成功"];
    }
    else
    {
        [self showHudWithContent:@"保存失败"];
    }
}

- (void) SBMainViewSaveDataViewDidTapCancel
{
    [self lew_dismissPopupView:YES];
}

- (void) SBMainViewSaveDataViewDidTapLocationWithBlock:(SBGetDPLocation)block
{
    SBDPLocationVCTL *dp_location_vctl = [[SBDPLocationVCTL alloc] initWithNibName:nil bundle:nil];
    dp_location_vctl.block = block;
    [self.navigationController pushViewController:dp_location_vctl animated:YES];
}



@end
