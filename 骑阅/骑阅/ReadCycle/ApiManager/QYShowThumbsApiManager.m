//
//  QYShowThumbsApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYShowThumbsApiManager.h"
#import "define.h"

@interface QYShowThumbsApiManager ()<CTAPIManagerValidator>

@property (nonatomic, assign) int pages;

@end

@implementation QYShowThumbsApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    self.pages = 0;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/show_thumbsup";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
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

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSNumber *uid = params[kuid];
    NSNumber *mid = params[kmid];
    if (self.isLoadMore) {
        
        self.pages = self.pages + 1;
        
    } else {
        
        self.pages = 0;
    }
    return @{kuid:uid,kpages:@(_pages),kmid:mid};
    
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
