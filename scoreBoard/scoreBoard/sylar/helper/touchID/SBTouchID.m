//
//  SBTouchID.m
//  scoreBoard
//
//  Created by sylar on 15/11/17.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBTouchID.h"
#import <LocalAuthentication/LocalAuthentication.h>
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBTouchID()

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBTouchID

+ (instancetype)share
{
    static SBTouchID *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBTouchID alloc] init];
    });
    return inst;
}

- (void) authorizeWithTouchID:(SBTouchIDSuccess)successBlock failure:(SBTouchIDFailure)failureBlock
{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"指纹验证";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        if (successBlock)
                                        {
                                            successBlock();
                                        }
                                        
                                    });
                                } else {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        if (failureBlock)
                                        {
                                            failureBlock();
                                        }
                                    });
                                }
                            }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failureBlock)
            {
                failureBlock();
            }

        });
    }

}






@end
