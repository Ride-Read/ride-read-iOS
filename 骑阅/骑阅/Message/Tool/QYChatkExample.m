//
//  QYChatkExample.m
//  骑阅
//
//  Created by chen liang on 2017/4/1.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYChatkExample.h"
#import "CTAppContext.h"
#import "define.h"
#import "QYUserReform.h"
#import "QYGetUsersInfoApiManager.h"
#import <ChatKit/LCCKSoundManager.h>

@interface QYChatkExample ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) QYGetUsersInfoApiManager *usersApi;
@property (nonatomic, strong) LCCKFetchProfilesCompletionHandler complete;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) QYUserReform *reform;
@property (nonatomic, assign) BOOL isLoading;

@end
@implementation QYChatkExample
@synthesize needAudio = _needAudio;
@synthesize needShake = _needShake;

static NSString *const LCCKAPPID = @"oHGfemDQX4jaHgn9Rzmn10YE-gzGzoHsz";
static NSString *const LCCKAPPKEY = @"qJDqp18BOykwgwNsFXJ8YxEn";
NSString * const KReciveMessagNotiFation = @"KReciveMessagNotiFation";

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
                                                success();
                                            } else {
                                                
                                                failed(error);
                                            }
                                        }];
    // TODO:
}


#pragma mark - private method

- (void)setFetchProfiles {
    
    [[LCChatKit sharedInstance] setFetchProfilesBlock:^(NSArray<NSString *> *userIds, LCCKFetchProfilesCompletionHandler completionHandler) {
        
        
        if (self.isLoading) {
            
            self.complete = completionHandler;
            return ;
        }
        self.complete = completionHandler;
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        self.params = @{kuser_ids:[userIds componentsJoinedByString:@","],kuid:uid};
        
        [self.usersApi loadData];
        self.isLoading = YES;
   
    }];
}

+ (void)fetchUnreadMessageNumber:(void (^)(NSUInteger))unreadBlock {
    
    [[LCCKConversationListService sharedInstance] findRecentConversationsWithBlock:^(NSArray *conversations, NSInteger totalUnreadCount, NSError *error) {
      
        if (error) {
            
            return ;
        }
        unreadBlock(totalUnreadCount);
    }];
}
+ (NSUInteger)unreadMessage {
    
    
    [[LCChatKit sharedInstance] increaseUnreadCountWithConversationId:@""];
    return 0;
}

+ (void)test {
    
    [[LCChatKit sharedInstance] setFilterMessagesBlock:^(AVIMConversation *conversation, NSArray<AVIMTypedMessage *> *messages, LCCKFilterMessagesCompletionHandler completionHandler) {
       
        completionHandler(messages,nil);
        [[NSNotificationCenter defaultCenter] postNotificationName:KReciveMessagNotiFation object:nil];
    }];
  
}

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    
    return self.params;
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    NSError *error = [NSError errorWithDomain:@"error" code:500 userInfo:nil];
    self.complete(nil,error);
  
    self.isLoading = NO;
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    self.isLoading = NO;
   NSArray *array =  [self.usersApi fetchDataWithReformer:self.reform];
    self.complete(array,nil);
}


- (QYGetUsersInfoApiManager *)usersApi {
    
    if (!_usersApi) {
        
        _usersApi = [[QYGetUsersInfoApiManager alloc] init];
        _usersApi.delegate = self;
        _usersApi.paramSource = self;
    }
    return _usersApi;
}

- (QYUserReform *)reform {
    
    if (!_reform) {
        
        _reform = [[QYUserReform alloc] init];
    }
    return _reform;
}

- (BOOL)needAudio {
    
    LCCKSoundManager *manager = [LCCKSoundManager defaultManager];
    return manager.needPlaySoundWhenNotChatting;
}

- (void)setNeedAudio:(BOOL)needAudio {
    
    _needAudio = needAudio;
    LCCKSoundManager *manager = [LCCKSoundManager defaultManager];
    manager.needPlaySoundWhenChatting = needAudio;
    manager.needPlaySoundWhenNotChatting = needAudio;
}

- (BOOL)needShake {

    LCCKSoundManager *manager = [LCCKSoundManager defaultManager];
     return manager.needVibrateWhenNotChatting;
}

- (void)setNeedShake:(BOOL)needShake {
    
    _needShake = needShake;
    LCCKSoundManager *manager = [LCCKSoundManager defaultManager];
    manager.needVibrateWhenNotChatting = needShake;
   
}
@end
