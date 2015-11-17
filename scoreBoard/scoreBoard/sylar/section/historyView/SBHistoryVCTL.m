//
//  SBHistoryVCTL.m
//  scoreBoard
//
//  Created by sylar on 15/10/15.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBHistoryVCTL.h"
#import "SBHistoryViewCell.h"
#import "SBHistoryViewAutoSaveCell.h"
#import "SBLocalSaveHelper.h"
#import "SBLocalSaveModel.h"
#import "SBData.h"
#import "SBAutoSaveVCTL.h"
#import "SBTouchID.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHistoryVCTL ()
<UITableViewDataSource, UITableViewDelegate,
SBHistoryViewCellDelegate, MGSwipeTableCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *data; // array of SBLocalSaveModel
@property (nonatomic, strong) NSMutableArray *editData; // array of SBLocalSaveModel 编辑的时候用的
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIBarButtonItem* rightBtn;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHistoryVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // data
    _data = [[SBData share] getPlistModels];
    _isEditing = NO;
    
    // table view
    [_tableView registerNib:[UINib nibWithNibName:@"SBHistoryViewCell" bundle:nil] forCellReuseIdentifier:[SBHistoryViewCell getCellId]];
    [_tableView registerNib:[UINib nibWithNibName:@"SBHistoryViewAutoSaveCell" bundle:nil] forCellReuseIdentifier:[SBHistoryViewAutoSaveCell getCellId]];
    UIView *footer = [[UIView alloc] init];
    _tableView.tableFooterView = footer;
    _tableView.estimatedRowHeight = 40;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    self.title = @"历史版本";
    
    UIBarButtonItem *right_button = [[UIBarButtonItem alloc] initWithTitle:@"同步  " style:UIBarButtonItemStylePlain target:self action:@selector(btnRightNaviButton)];
    _rightBtn = right_button;
    self.navigationItem.rightBarButtonItem = right_button;
}

- (void) btnRightNaviButton
{
    if (_isEditing == NO)
    {
        // 指纹解锁
        [[SBTouchID share] authorizeWithTouchID:^{
            NSLog(@"同步成功");
            _rightBtn.title = @"完成  ";
            _isEditing = YES;
            _editData = [_data mutableCopy];
        } failure:^{
            [self showHudWithContent:@"同步失败"];
        }];
    }
    else
    {
        // 同步数据
        [self showHudAnimation];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[SBLocalSaveHelper share] synchronizeWithData:_editData block:^(BOOL success) {
                [self hideHudAnimation];
                if (success)
                {
                    [self showHudWithContent:@"同步成功"];
                }
                else
                {
                    [self showHudWithContent:@"同步失败"];
                }
            }];
        });
    }
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillDisappear:animated];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = 0;
    if (_isEditing == NO)
    {
        rt = [_data count] + 1;
    }
    else
    {
        rt = [_editData count] + 1;
    }
    
    return rt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *rt = nil;
    NSInteger row = indexPath.row;
    if (row == 0)
    {
        // auto save
        SBHistoryViewAutoSaveCell *auto_save_cell = [tableView dequeueReusableCellWithIdentifier:[SBHistoryViewAutoSaveCell getCellId] forIndexPath:indexPath];
        
        rt = auto_save_cell;
    }
    else
    {
        SBHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SBHistoryViewCell getCellId] forIndexPath:indexPath];
        SBLocalSaveModel *model = nil;
        if (_isEditing)
        {
            model = [_editData objectAtIndex:row-1];
        }
        else
        {
            model = [_data objectAtIndex:row-1];
        }
        [cell setWithData:model];
        cell.delegateTap = self;
        cell.delegate = self;
        [cell setWithDeleteButton];
        rt = cell;
    }
    return rt;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isEditing == NO)
    {
        NSInteger row = indexPath.row;
        if (row == 0)
        {
            // select auto save
            SBAutoSaveVCTL *auto_save_vctl = [[SBAutoSaveVCTL alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:auto_save_vctl animated:YES];
        }
        else
        {
            UIAlertController *alert_vctl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *use_score_button = [UIAlertAction actionWithTitle:@"使用这个" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                SBLocalSaveModel *model = [_data objectAtIndex:row-1];
                [[SBData share] revertWithKey:model.key];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert_vctl addAction:use_score_button];
            UIAlertAction *cancel_button = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert_vctl addAction:cancel_button];
            [self presentViewController:alert_vctl animated:YES completion:nil];
        }
    }
}

#pragma mark - SBHistoryViewCellDelegate
- (void)SBHistoryViewCellDidTapDelete:(SBHistoryViewCell *)cell
{
    NSIndexPath *index_path = [_tableView indexPathForCell:cell];
    [_editData removeObjectAtIndex:index_path.row-1];
    [_tableView deleteRowsAtIndexPaths:@[index_path] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - MGSwipeTableCellDelegate
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction fromPoint:(CGPoint) point
{
    return _isEditing;
}


@end
