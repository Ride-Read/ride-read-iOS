//
//  QYScaleApiManagerTool.m
//  骑阅
//
//  Created by chen liang on 2017/4/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYScaleApiManagerTool.h"
#import "define.h"
#import "QYRecentlyCycleReform.h"

@interface QYScaleApiManagerTool ()
@property (nonatomic, assign) int presScale;
@property (nonatomic, assign) int currentScale;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) QYRecentlyCycleReform *reform;
@property (nonatomic, copy) void(^result)(NSArray *array,NSError *error);

@end
@implementation QYScaleApiManagerTool

#pragma mark - life cycle
- (instancetype)init {
    
    self = [super init];
    
    self.presScale = 0;
    return self;
}
#pragma mark - private method
- (void)dataWithScale:(CGFloat)scale location:(CLLocation *)location block:(void (^)(NSArray *, NSError *))block {
    
    self.result = block;
    self.location = location;
    int value = scale;
    switch (value) {
        case 3:
            self.currentScale = 3;
            break;
            
        case 4:
            self.currentScale = 4;
            break;

        case 5:
            self.currentScale = 5;
            break;

        case 6:
            self.currentScale = 6;
            break;

        case 7:
            self.currentScale = 7;
            break;

        case 8:
            self.currentScale = 8;
            break;

        case 9:
            self.currentScale = 9;
            break;

        case 10:
            self.currentScale = 10;
            break;

        case 11:
            self.currentScale = 11;
            break;

        case 12:
            self.currentScale = 12;
            break;

        case 13:
            self.currentScale = 13;
            break;
        case 14:
            self.currentScale = 14;
            break;
        case 15:
            self.currentScale = 15;
            break;
        case 16:
            self.currentScale = 16;
            break;
        case 17:
            self.currentScale = 17;
            break;
        case 18:
            self.currentScale = 18;
            break;
        case 19:
            self.currentScale = 19;
            break;
        case 20:
            self.currentScale = 20;
            break;

            
        default:
            break;
    }
    self.currentScale = scale;
    if (self.presScale == 0) {
        
        [self.apiManager loadData];
        
    } else {
        
        if (self.presScale == self.currentScale) {
            
            return;
        }
        [self.apiManager loadData];
    }
    self.presScale = self.currentScale;
}

#pragma mark - CTApiManagerParmSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kuid:uid?:@(-1),klatitude:@(self.location.coordinate.latitude),klongitude:@(self.location.coordinate.longitude),kscaling_ratio:@(self.currentScale)};
}

#pragma mark - CTApiManagerCallbackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
 
    NSArray *result = [self.apiManager fetchDataWithReformer:self.reform];
    self.result(result,nil);
    MyLog(@"success get scale data");
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    if (manager == self.apiManager) {
        
        self.result(nil,nil);
        [MBProgressHUD showMessageAutoHide:@"附近阅圈加载失败" view:nil];
    }
    
}
#pragma mark - getter and setter

- (QYRecentlyCycleReform *)reform {
    
    if (!_reform) {
        
        _reform = [[QYRecentlyCycleReform alloc] init];
    }
    return _reform;
}

@end
