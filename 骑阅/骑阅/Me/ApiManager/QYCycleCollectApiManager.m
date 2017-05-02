//
//  QYCycleCollectApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleCollectApiManager.h"
#import "define.h"

@interface QYCycleCollectApiManager ()<CTAPIManagerValidator>
@property (nonatomic, assign) int pages;
@end
@implementation QYCycleCollectApiManager
- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/show_collect_moment";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}
- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSString *uid = params[kuid];
    if (self.isLoadMore) {
        
        self.pages = self.pages + 1;
        
    } else {
        
        self.pages = 0;
    }
    return @{kuid:uid};
    
}


#pragma mark - public method

- (NSInteger)loadData {
    
    self.pages = 0;
    self.isLoadMore = NO;
    self.isRefesh = NO;
    return [super loadData];
}
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
        
        self.pages = self.pages - 1;
    }
}


@end
