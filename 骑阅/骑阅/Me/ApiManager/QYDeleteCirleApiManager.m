//
//  QYDeleteCirleApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/5/1.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYDeleteCirleApiManager.h"
#import "define.h"

@interface QYDeleteCirleApiManager ()<CTAPIManagerValidator>

@end
@implementation QYDeleteCirleApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/remove_moment";
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
