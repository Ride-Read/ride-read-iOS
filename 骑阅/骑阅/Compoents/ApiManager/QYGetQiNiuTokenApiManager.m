//
//  QYGetQiNiuTokenApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYGetQiNiuTokenApiManager.h"
#import "define.h"

@interface QYGetQiNiuTokenApiManager ()<CTAPIManagerValidator>

@end
@implementation QYGetQiNiuTokenApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}
- (NSString *)methodName {

    return @"util/qiniu_token";
}
- (NSString *)serviceType {
    
    return kCTServiceYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}

#pragma mark -validator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    
    NSNumber *status = data[kstatus];
    if (status.integerValue != 0) {
        
        return NO;
    }
    return YES;
}


@end
