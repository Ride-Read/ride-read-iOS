//
//  QYVersionUpdateApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/29.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYVersionUpdateApiManager.h"
#import "define.h"

@interface QYVersionUpdateApiManager ()<CTAPIManagerValidator>

@end
@implementation QYVersionUpdateApiManager
- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"util/verify_version_number";
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

#pragma mark - CTAPIManagerValidator
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

@end
