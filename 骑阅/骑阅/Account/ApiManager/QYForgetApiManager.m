//
//  QYForgetApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYForgetApiManager.h"
#import "define.h"
#import "NSString+QYMD5.h"

@interface QYForgetApiManager ()<CTAPIManagerValidator>

@end
@implementation QYForgetApiManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.validator = self;
    }
    return self;
}
- (NSString *)methodName {
    
    return @"users/reset_password";
}

- (NSString *)serviceType {
    
    return kCTServiceYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSString *username = params[kphonenumber];
    NSString *pwd = params[knew_password];
    pwd = [pwd sha1];
    return @{kphonenumber:username,knew_password:pwd};
    
}
- (BOOL)shouldCache {
    
    return NO;
}

#pragma mark - CTAPIValidtor
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    NSString *username = data[kphonenumber];
    NSString *pwd = data[knew_password];
    if (username.length <= 0 || pwd.length < 6) {
        
        return NO;
    }
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
