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
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBHistoryVCTL ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *data; // array of SBLocalSaveModel

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBHistoryVCTL

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // data
    _data = [[SBData share] getPlistModels];
    
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
    self.navigationItem.rightBarButtonItem = right_button;
    
}

- (void) btnRightNaviButton
{
    NSLog(@"btnRightNaviButton");
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillDisappear:animated];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rt = [_data count] + 1;
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
        [cell setWithData:[_data objectAtIndex:row-1]];
        
        rt = cell;
    }
    return rt;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

@end
