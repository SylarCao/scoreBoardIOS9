//
//  SBMainViewHeader.m
//  scoreBoard
//
//  Created by sylar on 15/9/25.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBMainViewHeader.h"
#import "SBCommonDefine.h"
#import "SBData.h"
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBMainViewHeader()

@property (nonatomic, strong) NSMutableArray *stackViewSubViews;
@property (nonatomic, strong) UIStackView *stackView;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBMainViewHeader

+ (NSString *) getHeaderId
{
    NSString *rt = @"SBMainViewHeader_header_id";
    return rt;
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setInitialValue];
    }
    return self;
}

- (void) setInitialValue
{
    // color
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    // function view
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSBMainViewLineNumberWidth, kSBMainViewHeaderHeight)];
    v1.backgroundColor = kSBMainViewLineNumberBKGColor;
    [self.contentView addSubview:v1];
    UIImageView *imgv_setting = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_setting"]];
    imgv_setting.frame = v1.bounds;
    imgv_setting.contentMode = UIViewContentModeCenter;
    [v1 addSubview:imgv_setting];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTap1)];
    [v1 addGestureRecognizer:tap1];
    
    UILongPressGestureRecognizer *ll = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPress:)];
    ll.minimumPressDuration = 1.0;
    [v1 addGestureRecognizer:ll];
    
    // stack view
    _stackView = [[UIStackView alloc] initWithFrame:CGRectMake(kSBMainViewLineNumberWidth+1, 0, kScreenWidth-kSBMainViewLineNumberWidth-1, kSBMainViewHeaderHeight)];
    _stackView.spacing = 1;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    _stackView.distribution = UIStackViewDistributionFillEqually;
    [self.contentView addSubview:_stackView];
    
    _stackViewSubViews = [[NSMutableArray alloc] init];
}

- (void) btnTap1
{
    if ([_delegate respondsToSelector:@selector(SBMainViewHeaderDidTapAddBtn)])
    {
        [_delegate performSelector:@selector(SBMainViewHeaderDidTapAddBtn)];
    }
}

- (void) btnLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        // begin long press
        if ([_delegate respondsToSelector:@selector(SBMainViewHeaderDidLongpressAddBtn)])
        {
            [_delegate performSelector:@selector(SBMainViewHeaderDidLongpressAddBtn)];
        }
    }
}


- (void) refresh
{
    // data
    NSArray *current_persons = [SBData share].currentPlayers;
    
    if (current_persons.count == _stackView.arrangedSubviews.count)
    {
        for (int i=0; i<current_persons.count; i++)
        {
            SBPerson *person_i = [current_persons objectAtIndex:i];
            UILabel *lb_i = [_stackViewSubViews objectAtIndex:i];
            lb_i.text = person_i.name;
        }
    }
    else
    {
        // remove all the stackview subviews
        while (_stackView.arrangedSubviews.count > 0) {
            UIView *one_arrange_view = [_stackView.arrangedSubviews lastObject];
            [one_arrange_view removeFromSuperview];
        }
        [_stackViewSubViews removeAllObjects];
        
        // add subview
        for (int i=0; i<current_persons.count; i++)
        {
            SBPerson *each_person = [current_persons objectAtIndex:i];
            UILabel *each_lb = [[UILabel alloc] init];
            each_lb.text = each_person.name;
            each_lb.textAlignment = NSTextAlignmentCenter;
            each_lb.backgroundColor = kSBMainVIewScoreBkgColor12(i);
            [_stackViewSubViews addObject:each_lb];
            [_stackView addArrangedSubview:each_lb];
        }
    }
    
}







@end
