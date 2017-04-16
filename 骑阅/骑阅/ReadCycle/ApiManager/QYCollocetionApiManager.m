
//
//  QYCollocetionApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCollocetionApiManager.h"
#import "define.h"

@interface QYCollocetionApiManager ()<CTAPIManagerValidator>

@end

@implementation QYCollocetionApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/collect_moment";
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
