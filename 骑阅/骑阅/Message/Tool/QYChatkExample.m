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

@implementation QYChatkExample

static NSString *const LCCKAPPID = @"dYRQ8YfHRiILshUnfFJu2eQM-gzGzoHsz";
static NSString *const LCCKAPPKEY = @"ye24iIK6ys8IvaISMC4Bs5WK";
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
        
        
#warning test user message

        NSMutableArray *array = @[].mutableCopy;
        for (NSString *userid in userIds) {
            MyLog(@"the user id :%@",userid);
#warning do you net working to fetch the use message
            QYUser * user;
            
            if ([userid isEqualToString:@"1000"]) {
                
                user = [[QYUser alloc] init];
                user.uid = @(1000);
                user.face_url = @"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg";
                user.username = @"snow";
              //  if ([userid isEqualToString:@"1000"]) {
                    
                   // user = [QYUser userWithUserId:@"1000" name:@"snow" avatarURL:[NSURL URLWithString:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg"] clientId:@"1000"];
                //}
               // QYUser * user = [CTAppContext sharedInstance].currentUser;
              
            } else {
                
                user = [[QYUser alloc] init];
                user.uid = @(1001);
                user.face_url = @"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg";
                user.username = @"json";
                
            }
            
            [array addObject:user];
            completionHandler(array,nil);

        }
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

@end
