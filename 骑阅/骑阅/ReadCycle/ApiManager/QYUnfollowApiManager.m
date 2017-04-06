//
//  QYUnfollowApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/6.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUnfollowApiManager.h"
#import "define.h"
@interface QYUnfollowApiManager ()<CTAPIManagerValidator>

@end

@implementation QYUnfollowApiManager
- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"users/unfollow";
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
