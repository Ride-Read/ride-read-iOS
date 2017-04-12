//
//  CTLocationManager.m
//  yili
//
//  Created by casa on 15/10/12.
//  Copyright © 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "CTLocationManager.h"

NSString * const kLocationServiceStatusErrorNotifation = @"LocationServiceStatusErrorNotifation";
NSString * const kLocationResultNotifationl = @"LocationResultNotifationl";
@interface CTLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, assign, readwrite) CTLocationManagerLocationResult locationResult;
@property (nonatomic, assign, readwrite) CTLocationManagerLocationServiceStatus locationStatus;
@property (nonatomic, copy, readwrite) CLLocation *currentLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CTLocationManager

+ (instancetype)sharedInstance
{
    static CTLocationManager *locationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[CTLocationManager alloc] init];
    });
    return locationManager;
}

- (void)startLocation
{
    if ([self checkLocationStatus]) {
        self.locationResult = CTLocationManagerLocationResultLocating;
        [self.locationManager startUpdatingLocation];
    } else {
        [self failedLocationWithResultType:CTLocationManagerLocationResultFail statusType:self.locationStatus];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServiceStatusErrorNotifation object:nil];
    }
}

- (void)stopLocation
{
    if ([self checkLocationStatus]) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)restartLocation
{
    [self stopLocation];
    [self startLocation];
}

- (void)reverseGeocodeLocation:(void (^)(NSArray *, NSError *))complteHander {
    
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            
            CLPlacemark *plcase = placemarks[0];
            NSLog(@"plcate:%@",plcase);
            NSLog(@"name:%@,%@,%@,%@,%@",plcase.name,plcase.administrativeArea,plcase.subAdministrativeArea,plcase.locality,plcase.subLocality);
            NSString *site = [NSString stringWithFormat:@"%@.%@",plcase.locality,plcase.name];
            complteHander(@[site],nil);
        }
    }];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [manager.location copy];
    NSLog(@"Current location is %@", self.currentLocation);
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationResultNotifationl object:nil userInfo:@{}];
    [self stopLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //如果用户还没选择是否允许定位，则不认为是定位失败
    if (self.locationStatus == CTLocationManagerLocationServiceStatusNotDetermined) {
        return;
    }
    
    //如果正在定位中，那么也不会通知到外面
    if (self.locationResult == CTLocationManagerLocationResultLocating) {
        return;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationStatus = CTLocationManagerLocationServiceStatusOK;
        [self restartLocation];
    } else {
        if (self.locationStatus != CTLocationManagerLocationServiceStatusNotDetermined) {
            [self failedLocationWithResultType:CTLocationManagerLocationResultDefault statusType:CTLocationManagerLocationServiceStatusNoAuthorization];
        } else {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
        }
    }
}

#pragma mark - private methods
- (void)failedLocationWithResultType:(CTLocationManagerLocationResult)result statusType:(CTLocationManagerLocationServiceStatus)status
{
    self.locationResult = result;
    self.locationStatus = status;
}

- (BOOL)checkLocationStatus;
{
    BOOL result = NO;
    BOOL serviceEnable = [self locationServiceEnabled];
    CTLocationManagerLocationServiceStatus authorizationStatus = [self locationServiceStatus];
    if (authorizationStatus == CTLocationManagerLocationServiceStatusOK && serviceEnable) {
        result = YES;
    }else if (authorizationStatus == CTLocationManagerLocationServiceStatusNotDetermined) {
        result = YES;
    }else{
        result = NO;
    }
    
    if (serviceEnable && result) {
        result = YES;
    }else{
        result = NO;
    }
    
    if (result == NO) {
        [self failedLocationWithResultType:CTLocationManagerLocationResultFail statusType:self.locationStatus];
    }
    
    return result;
}

- (BOOL)locationServiceEnabled
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationStatus = CTLocationManagerLocationServiceStatusOK;
        return YES;
    } else {
        self.locationStatus = CTLocationManagerLocationServiceStatusUnknownError;
        return NO;
    }
}

- (CTLocationManagerLocationServiceStatus)locationServiceStatus
{
    self.locationStatus = CTLocationManagerLocationServiceStatusUnknownError;
    BOOL serviceEnable = [CLLocationManager locationServicesEnabled];
    if (serviceEnable) {
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        switch (authorizationStatus) {
            case kCLAuthorizationStatusNotDetermined:
                self.locationStatus = CTLocationManagerLocationServiceStatusNotDetermined;
                break;
                
            case kCLAuthorizationStatusAuthorizedAlways :
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                self.locationStatus = CTLocationManagerLocationServiceStatusOK;
                break;
                
            case kCLAuthorizationStatusDenied:
                self.locationStatus = CTLocationManagerLocationServiceStatusNoAuthorization;
                break;
                
            default:
                break;
        }
    } else {
        self.locationStatus = CTLocationManagerLocationServiceStatusUnAvailable;
    }
    return self.locationStatus;
}

#pragma mark - getters and setters
- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

@end
