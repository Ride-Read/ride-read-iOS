//
//  QYChatkExample.m
//  骑阅
//
//  Created by chen liang on 2017/4/1.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYChatkExample.h"
#import "CTAppContext.h"

@implementation QYChatkExample

static NSString *const LCCKAPPID = @"dYRQ8YfHRiILshUnfFJu2eQM-gzGzoHsz";
static NSString *const LCCKAPPKEY = @"ye24iIK6ys8IvaISMC4Bs5WK";


+ (instancetype)sharedInstance {
    static QYChatkExample *_sharedLCChatKitExample = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLCChatKitExample = [[self alloc] init];
    });
    return _sharedLCChatKitExample;
}
+ (void)invokeThisMethodInDidFinishLaunching {
    
    [AVIMClient setUserOptions:@{ AVIMUserOptionUseUnread : @(YES) }];
    [AVIMClient setTimeoutIntervalInSeconds:20];
}

+ (void)invokeThisMethodBeforeLogoutSuccess:(LCCKVoidBlock)success failed:(LCCKErrorBlock)failed {
    //    [AVOSCloudIM handleRemoteNotificationsWithDeviceToken:nil];
    [[LCChatKit sharedInstance] removeAllCachedProfiles];
    [[LCChatKit sharedInstance] closeWithCallback:^(BOOL succeeded, NSError *error) {
        
        
        if (succeeded)
            !success?:success();
        else
            !failed?:failed(error);
        
    }];
}
- (void)exampleInit {
    
    [LCChatKit setAppId:LCCKAPPID appKey:LCCKAPPKEY];
    [self setFetchProfiles];
    
}


+ (void)invokeThisMethodAfterLoginSuccessWithClientId:(NSString *)clientId
                                              success:(LCCKVoidBlock)success
                                               failed:(LCCKErrorBlock)failed {
    [[self sharedInstance] exampleInit];
    [[LCChatKit sharedInstance] openWithClientId:clientId
                                        callback:^(BOOL succeeded, NSError *error) {
                                            if (succeeded) {
                                                !success ?: success();
                                            } else {
                                                !failed ?: failed(error);
                                            }
                                        }];
    // TODO:
}


#pragma mark - private method

- (void)setFetchProfiles {
    
    [[LCChatKit sharedInstance] setFetchProfilesBlock:^(NSArray<NSString *> *userIds, LCCKFetchProfilesCompletionHandler completionHandler) {
        
        
#warning test user message
        
        for (NSString *userid in userIds) {
            NSMutableArray *array = @[].mutableCopy;
#warning do you net working to fetch the use message
            if (userid) {
                
                QYUser * user = [CTAppContext sharedInstance].currentUser;
                [array addObject:user];
            }
            completionHandler(array,nil);
        }
    }];
}


@end
