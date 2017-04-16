//
//  QYShowOneMonentApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYShowOneMonentApiManager.h"
#import "define.h"

@interface QYShowOneMonentApiManager ()<CTAPIManagerValidator>

@end

@implementation QYShowOneMonentApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/show_one_moment";
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
