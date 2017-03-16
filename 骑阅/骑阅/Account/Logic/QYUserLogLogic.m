//
//  QYUserLogLogic.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUserLogLogic.h"
#import "QYLoginApiManager.h"
#import "CTAppContext.h"
#import "define.h"

@implementation QYUserLogLogic
@synthesize apiManager;

- (id)logic:(CLAppLogic *)logic reformNetWorking:(id)data {
    
    if ([data isKindOfClass:[NSString class]]) {
        
        return nil;
    }
    NSDictionary *user_data = data[kdata];
    //QYUser *user = [QYUser userWithDict:user_data];
    [[CTAppContext sharedInstance] setUserInfo:user_data];
    return user_data;
}

- (CTAPIBaseManager *)apiManager {
    
    if (!apiManager) {
        
        apiManager = [[QYLoginApiManager alloc] init];
        apiManager.interceptor = self;
        apiManager.delegate = self.delegate;
        apiManager.paramSource = self.paramSource;
    }
    return apiManager;
}
@end
