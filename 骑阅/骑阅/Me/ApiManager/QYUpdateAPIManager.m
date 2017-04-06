//
//  QYUpdateAPIManager.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/4.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUpdateAPIManager.h"
#import "define.h"

@interface QYUpdateAPIManager ()<CTAPIManagerValidator>

@end

@implementation QYUpdateAPIManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"users/update";
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
