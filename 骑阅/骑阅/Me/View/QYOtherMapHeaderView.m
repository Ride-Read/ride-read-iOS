//
//  QYOtherMapHeaderView.m
//  骑阅
//
//  Created by chen liang on 2017/4/29.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYOtherMapHeaderView.h"

@implementation QYOtherMapHeaderView
@synthesize personApi;
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    if (manager == self.personApi) {
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        NSNumber *user_id = self.user.uid;
        return @{kuid:uid?:@(-1),kuser_id:user_id};
        
    }
    return nil;
}

- (void)clickPersonMap {
    
    if (self.user.is_followed.integerValue == 0 || self.user.is_followed.integerValue == 1) {
        
        [super clickPersonMap];
    } else {
        
        [MBProgressHUD showMessageAutoHide:@"未关注该用户，无法操作" view:nil];
    }
}

- (QYPersionMapApiManager *)personApi {
    
    if (!personApi) {
        
        personApi = [[QYOtherPersonMapApiManager alloc] init];
        personApi.delegate = self;
        personApi.paramSource = self;
    }
    return personApi;
}



@end
