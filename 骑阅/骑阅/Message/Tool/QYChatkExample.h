//
//  QYChatkExample.h
//  骑阅
//
//  Created by chen liang on 2017/4/1.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QYUser.h"

FOUNDATION_EXTERN NSString * const KReciveMessagNotiFation;
@interface QYChatkExample : NSObject

+ (instancetype)sharedInstance;
/*!
 *  入口胶水函数：初始化入口函数
 *
 *  程序完成启动，在 appdelegate 中的 `-[AppDelegate didFinishLaunchingWithOptions:]` 一开始的地方调用.
 */
+ (void)invokeThisMethodInDidFinishLaunching;

/*!
 *  入口胶水函数：登入入口函数
 *
 *  用户即将退出登录时调用
 */
+ (void)invokeThisMethodAfterLoginSuccessWithClientId:(NSString *)clientId success:(LCCKVoidBlock)success failed:(LCCKErrorBlock)failed;

/*!
 *  入口胶水函数：登出入口函数
 *
 *  用户即将退出登录时调用
 */
+ (void)invokeThisMethodBeforeLogoutSuccess:(LCCKVoidBlock)success failed:(LCCKErrorBlock)failed;

+ (void)fetchUnreadMessageNumber:(void(^)(NSUInteger unread))unreadBlock;

+ (void)test;

@end
