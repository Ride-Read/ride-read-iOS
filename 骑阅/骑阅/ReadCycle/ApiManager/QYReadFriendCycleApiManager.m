//
//  QYReadFriendCycleApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadFriendCycleApiManager.h"
#import "define.h"

@interface QYReadFriendCycleApiManager ()<CTAPIManagerValidator>
@property (nonatomic, assign) int pages;

@end
@implementation QYReadFriendCycleApiManager
- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    self.pages = 0;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/show_moment";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}

- (BOOL)shouldCache {
    
    return NO;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSNumber *type = params[ktype];
    NSString *uid = params[kuid];
    NSNumber *lati = params[klatitude];
    NSNumber *longit = params[klongitude];
    if (self.isLoadMore) {
        
        self.pages = self.pages + 1;
        
    } else {
        
        self.pages = 0;
    }
    return @{ktype:type,kuid:uid,kpages:@(_pages),klongitude:longit,klatitude:lati};
    
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
