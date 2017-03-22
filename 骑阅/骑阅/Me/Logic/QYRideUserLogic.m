//
//  QYRideUserLogic.m
//  骑阅
//
//  Created by chen liang on 2017/3/22.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRideUserLogic.h"
#import "CTAppContext.h"
#import "define.h"
#import "QYRideUserApiManager.h"

@implementation QYRideUserLogic
@synthesize apiManager;

- (id)logic:(CLAppLogic *)logic reformNetWorking:(id)data {
    
    if ([data isKindOfClass:[NSString class]]) {
        
        QYUser *user = [CTAppContext sharedInstance].currentUser;
        return user;
    }
    
    NSDictionary *dict = data;
    NSDictionary *info = dict[kdata];
    QYUser *user = [QYUser userWithDict:info];
    [CTAppContext sharedInstance].userInfo = info;
    return user;
}

- (CTAPIBaseManager *)apiManager {
    
    if (!apiManager) {
        
        apiManager = [[QYRideUserApiManager alloc] init];
        apiManager.delegate = self.delegate;
        apiManager.paramSource = self.paramSource;
        apiManager.interceptor = self;
    }
    return apiManager;
}
@end
