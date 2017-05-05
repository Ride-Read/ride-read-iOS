//
//  QYPersonAnnotion.m
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonAnnotion.h"

@interface QYPersonAnnotion ()
@property (nonatomic, strong) CLLocation *location;

@end
@implementation QYPersonAnnotion

- (instancetype)init {
    
    self = [super init];
    return self;
}
- (CLLocation *)locationForAnnotion {
    
    if (!_location) {
        
        _location = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    }
    return _location;
}
@end
