//
//  UIViewController+LewPopupViewController.h
//  LewPopupViewController
//
//  Created by pljhonglu on 15/3/4.
//  Copyright (c) 2015年 pljhonglu. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol LewPopupAnimation <NSObject>
@required
- (void)showView:(UIView*)popupView overlayView:(UIView*)overlayView;
- (void)dismissView:(UIView*)popupView overlayView:(UIView*)overlayView completion:(void (^)(void))completion;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
// my delegate
@protocol LewPopupViewControllerDelegate <NSObject>

@optional
/**
 *  click the background, try dismiss
 *
 *  @param allowDismiss (allowDismiss property)
 */
- (void) LewPopupViewControllerTryDismiss:(BOOL)allowDismiss;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface UIViewController (LewPopupViewController)
@property (nonatomic, retain, readonly) UIView *lewPopupView;
@property (nonatomic, retain, readonly) UIView *lewOverlayView;
@property (nonatomic, retain, readonly) id<LewPopupAnimation> lewPopupAnimation;

// my 2 property
@property (nonatomic, assign) BOOL lewAllowDismiss;   // if allow dismiss
@property (nonatomic, weak) id<LewPopupViewControllerDelegate> lewDelegate;

- (void)lew_presentPopupView:(UIView *)popupView animation:(id<LewPopupAnimation>)animation;
- (void)lew_presentPopupView:(UIView *)popupView animation:(id<LewPopupAnimation>)animation dismissed:(void(^)(void))dismissed;

- (void)lew_dismissPopupView;
- (void) lew_dismissPopupView:(BOOL)force;   // if force, dismiss
- (void)lew_dismissPopupViewWithanimation:(id<LewPopupAnimation>)animation;
@end
////////////////////////////////////////////////////////////////////////////////////////////////////////