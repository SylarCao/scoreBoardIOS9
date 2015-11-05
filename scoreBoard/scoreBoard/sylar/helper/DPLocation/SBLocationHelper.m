//
//  SBLocationHelper.m
//  scoreBoard
//
//  Created by sylar on 15/11/5.
//  Copyright © 2015年 sylar. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "SBLocationHelper.h"
#import "SBHelper.h"
////////////////////////////////////////////////////////////////////////////////////////////////////////
# define kSBLocationTimeInterval (600)    // 每10分钟才重新请求下地址
////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SBLocationHelper()
<CLLocationManagerDelegate>

@property (nonatomic, assign) NSInteger time0;  // 上一次调用的时间
@property (nonatomic, strong) SBLocationBlock block;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D lastLocationCoordinate;

@end
////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SBLocationHelper

+ (instancetype) share
{
    static SBLocationHelper *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[SBLocationHelper alloc] init];
    });
    return inst;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _time0 = 0;
    }
    return self;
}

- (void) getOneLocationWithBlock:(SBLocationBlock)block
{
    CGFloat time0_now = [[SBHelper share] getTime0];
    if (time0_now - _time0 > kSBLocationTimeInterval)
    {
        _block = block;
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        {
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];   // requestWhenInUseAuthorization = 4
            }
        }
        [_locationManager stopUpdatingLocation];
        [_locationManager startUpdatingLocation];
    }
    else
    {
        if (block)
        {
            block(YES, _lastLocationCoordinate.longitude, _lastLocationCoordinate.latitude);
        }
    }
    
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // 没有开设置就 跑到这里来
    NSLog(@"fail");
    if (_block)
    {
        _block(NO, 0, 0);
    }

}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *ll = [locations lastObject];
    [manager stopUpdatingLocation];
    
    // success  这里会跑来很多次，用第一次的，不是最精确的，但是已经够精确了
    _time0 = [[SBHelper share] getTime0];
    _lastLocationCoordinate = ll.coordinate;
    if (_block)
    {
        _block(YES, ll.coordinate.longitude, ll.coordinate.latitude);
    }
}


@end
