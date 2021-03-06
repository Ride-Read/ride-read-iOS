//
//  QYAddCommnetApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/8.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAddCommnetApiManager.h"
#import "define.h"

@interface QYAddCommnetApiManager ()<CTAPIManagerValidator>

@end
@implementation QYAddCommnetApiManager
- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/add_comment";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
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
