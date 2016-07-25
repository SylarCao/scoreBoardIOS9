//
//  UIViewController+LewPopupViewController.m
//  LewPopupViewController
//
//  Created by pljhonglu on 15/3/4.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//

#import "UIViewController+LewPopupViewController.h"
#import <objc/runtime.h>
#import "LewPopupBackgroundView.h"


#define kLEWPopupView @"kLEWPopupView"
#define kLEWOverlayView @"kLEWOverlayView"
#define kLEWPopupViewDismissedBlock @"kLEWPopupViewDismissedBlock"
#define KLEWPopupAnimation @"KLEWPopupAnimation"
#define kLEWPopupAnimationAllowDismiss @"kLEWPopupAnimationAllowDismiss"
#define kLEWPopupViewControllerDelegate @"kLEWPopupViewControllerDelegate"

#define kLEWPopupViewTag 8002
#define kLEWOverlayViewTag 8003

@interface UIViewController (LewPopupViewControllerPrivate)
@property (nonatomic, retain) UIView *lewPopupView;
@property (nonatomic, retain) UIView *lewOverlayView;
@property (nonatomic, copy) void(^lewDismissCallback)(void);
@property (nonatomic, retain) id<LewPopupAnimation> popupAnimation;
@property (nonatomic, assign) BOOL lewAllowDismiss;
- (UIView*)topView;
@end

@implementation UIViewController (LewPopupViewController)

#pragma public method
- (void)lew_presentPopupView:(UIView *)popupView animation:(id<LewPopupAnimation>)animation dismissed:(void (^)(void))dismissed{
    [self presentPopupView:popupView animation:animation dismissed:dismissed];
}

- (void)lew_presentPopupView:(UIView *)popupView animation:(id<LewPopupAnimation>)animation{
    [self presentPopupView:popupView animation:animation dismissed:nil];
}

- (void)lew_dismissPopupViewWithanimation:(id<LewPopupAnimation>)animation{
    [self dismissPopupViewWithAnimation:animation];
}

- (void)lew_dismissPopupView{
    [self lew_dismissPopupView:NO];
}

- (void) lew_dismissPopupView:(BOOL)force
{
    [self dismissPopupViewWithAnimation:self.lewPopupAnimation force:force];
}

#pragma mark - inline property
- (UIView *)lewPopupView {
    return objc_getAssociatedObject(self, kLEWPopupView);
}

- (void)setLewPopupView:(UIViewController *)lewPopupView {
    objc_setAssociatedObject(self, kLEWPopupView, lewPopupView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lewOverlayView{
    return objc_getAssociatedObject(self, kLEWOverlayView);
}

- (void)setLewOverlayView:(UIView *)lewOverlayView {
    objc_setAssociatedObject(self, kLEWOverlayView, lewOverlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(void))lewDismissCallback{
    return objc_getAssociatedObject(self, kLEWPopupViewDismissedBlock);
}

- (void)setLewDismissCallback:(void (^)(void))lewDismissCallback{
    objc_setAssociatedObject(self, kLEWPopupViewDismissedBlock, lewDismissCallback, OBJC_ASSOCIATION_COPY);
}

- (id<LewPopupAnimation>)lewPopupAnimation{
    return objc_getAssociatedObject(self, KLEWPopupAnimation);
}

- (void)setLewPopupAnimation:(id<LewPopupAnimation>)lewPopupAnimation{
    objc_setAssociatedObject(self, KLEWPopupAnimation, lewPopupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)lewAllowDismiss
{
    NSNumber *number = objc_getAssociatedObject(self, kLEWPopupAnimationAllowDismiss);
    NSInteger rt = [number boolValue];
    return rt;
}

- (void) setLewAllowDismiss:(BOOL)lewAllowDismiss
{
    NSNumber *number = [NSNumber numberWithBool:lewAllowDismiss];
    objc_setAssociatedObject(self, kLEWPopupAnimationAllowDismiss, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<LewPopupViewControllerDelegate>)lewDelegate
{
    return objc_getAssociatedObject(self, kLEWPopupViewControllerDelegate);
}

- (void) setLewDelegate:(id<LewPopupViewControllerDelegate>)lewDelegate
{
    objc_setAssociatedObject(self, kLEWPopupViewControllerDelegate, lewDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - view handle

- (void)presentPopupView:(UIView*)popupView animation:(id<LewPopupAnimation>)animation dismissed:(void(^)(void))dismissed{

    
    // check if source view controller is not in destination
    if ([self.lewOverlayView.subviews containsObject:popupView]) return;
    
    // fix issue #2
    if (self.lewOverlayView && self.lewOverlayView.subviews.count > 1) {
        [self dismissPopupViewWithAnimation:nil];
    }
    
    self.lewPopupView = nil;
    self.lewPopupView = popupView;
    self.lewPopupAnimation = nil;
    self.lewPopupAnimation = animation;
    
    UIView *sourceView = [self topView];

    // customize popupView
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kLEWPopupViewTag;
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    popupView.layer.shouldRasterize = YES;
    popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Add overlay
    if (self.lewOverlayView == nil) {
        UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
        overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayView.tag = kLEWOverlayViewTag;
        overlayView.backgroundColor = [UIColor clearColor];
        
        // BackgroundView
        UIView *backgroundView = [[LewPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundView.backgroundColor = [UIColor clearColor];
        [overlayView addSubview:backgroundView];
        
        // Make the Background Clickable
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lew_dismissPopupView)];
        [backgroundView addGestureRecognizer:tap];
        self.lewOverlayView = overlayView;
    }
    
    [self.lewOverlayView addSubview:popupView];
    [sourceView addSubview:self.lewOverlayView];

    self.lewOverlayView.alpha = 1.0f;
    popupView.center = self.lewOverlayView.center;
    if (animation) {
        [animation showView:popupView overlayView:self.lewOverlayView];
    }
    
    [self setLewDismissCallback:dismissed];

}

- (void) dismissPopupViewWithAnimation:(id<LewPopupAnimation>)animation
{
    [self dismissPopupViewWithAnimation:animation force:NO];
}

- (void)dismissPopupViewWithAnimation:(id<LewPopupAnimation>)animation force:(BOOL)forceDismiss{
    if (self.lewAllowDismiss == NO)
    {
        if ([self.lewDelegate respondsToSelector:@selector(LewPopupViewControllerTryDismiss:)])
        {
            [self.lewDelegate LewPopupViewControllerTryDismiss:self.lewAllowDismiss];
        }
        if (forceDismiss == NO)
        {
            return;
        }
    }
    else
    {
        if ([self.lewDelegate respondsToSelector:@selector(LewPopupViewControllerTryDismiss:)])
        {
            [self.lewDelegate LewPopupViewControllerTryDismiss:self.lewAllowDismiss];
        }
    }
    if (animation) {
        [animation dismissView:self.lewPopupView overlayView:self.lewOverlayView completion:^(void) {
            [self.lewOverlayView removeFromSuperview];
            [self.lewPopupView removeFromSuperview];
            self.lewPopupView = nil;
            self.lewPopupAnimation = nil;
            
            id dismissed = [self lewDismissCallback];
            if (dismissed != nil){
                ((void(^)(void))dismissed)();
                [self setLewDismissCallback:nil];
            }
        }];
    }else{
        [self.lewOverlayView removeFromSuperview];
        [self.lewPopupView removeFromSuperview];
        self.lewPopupView = nil;
        self.lewPopupAnimation = nil;
        
        id dismissed = [self lewDismissCallback];
        if (dismissed != nil){
            ((void(^)(void))dismissed)();
            [self setLewDismissCallback:nil];
        }
    }
}

-(UIView*)topView {
    return self.view;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
#pragma clang diagnostic pop
}


@end