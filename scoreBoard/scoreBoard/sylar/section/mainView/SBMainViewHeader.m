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
    // function view
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    v1.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:v1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTap1)];
    [v1 addGestureRecognizer:tap1];
    
    UILongPressGestureRecognizer *ll = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPress:)];
    ll.minimumPressDuration = 1.0;
    [v1 addGestureRecognizer:ll];
    
    // stack view
    _stackView = [[UIStackView alloc] initWithFrame:CGRectMake(kSBMainViewLineNumberWidth, 0, kScreenWidth-kSBMainViewLineNumberWidth, kSBMainViewHeaderHeight)];
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
        NSArray *stack_view_subview = _stackView.arrangedSubviews;
        for (UIView *each_view in stack_view_subview)
        {
            [_stackView removeArrangedSubview:each_view];
        }
        [_stackViewSubViews removeAllObjects];
        
        // add subview
        for (SBPerson *each_person in current_persons)
        {
            UILabel *each_lb = [[UILabel alloc] init];
            each_lb.text = each_person.name;
            each_lb.backgroundColor = [[SBHelper share] getRandomColor];
            [_stackViewSubViews addObject:each_lb];
            [_stackView addArrangedSubview:each_lb];
        }
    }
    
}







@end
