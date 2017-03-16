//
//  QYRegisterLogic.m
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRegisterLogic.h"
#import "define.h"
#import "QYUserRegisterApiManager.h"

@implementation QYRegisterLogic

@synthesize apiManager;
- (id)logic:(CLAppLogic *)logic reformNetWorking:(id)data {
    
    if ([data isEqualToString:kApiManagerNetWorkingError]) {
        
        return nil;
    }
    NSDictionary *user_data = data[kdata];
    //QYUser *user = [QYUser userWithDict:user_data];
    [[CTAppContext sharedInstance] setUserInfo:user_data];
    return nil;
}
- (CTAPIBaseManager *)apiManager {
    
    if (!apiManager) {
        
        apiManager = [[QYUserRegisterApiManager alloc] init];
        apiManager.interceptor = self;
        apiManager.paramSource = self.paramSource;
        apiManager.delegate  = self.delegate;
    }
    return apiManager;
}

@end
