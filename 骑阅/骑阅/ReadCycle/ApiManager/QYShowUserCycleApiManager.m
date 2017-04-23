//
//  QYShowUserCycleApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYShowUserCycleApiManager.h"
#import "define.h"

@interface QYShowUserCycleApiManager ()<CTAPIManagerValidator>
@property (nonatomic, assign) int pages;

@end
@implementation QYShowUserCycleApiManager
- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    self.pages = 0;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/show_user";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}

- (BOOL)shouldCache {
    
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSNumber *uid = params[kuid];
    NSNumber *lati = params[klatitude];
    NSNumber *longit = params[klongitude];
    NSNumber *user_id = params[kuser_id];
    if (self.isLoadMore) {
        
        self.pages = self.pages + 1;
        
    } else {
        
        self.pages = 0;
    }
    return @{kuid:uid,kpages:@(_pages),klongitude:longit,klatitude:lati,kuser_id:user_id};
    
    return nil;
}
#pragma mark - public method

- (void)loadNext {
    
    self.isLoadMore = YES;
    [self loadData];
}

- (void)loadLaste {
    
    self.isRefesh = YES;
    [self loadData];
}
#pragma mark -CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    
    NSNumber *status = data[kstatus];
    if (status.integerValue == 0) {
        
        return YES;
    }
    return NO;
}

-(void)afterPerformFailWithResponse:(CLURLResponse *)response {
    
    [super afterPerformFailWithResponse:response];
    if (self.pages != 0 && self.isLoadMore) {
        
        self.pages = self.pages - 10;
    }
}
@end
