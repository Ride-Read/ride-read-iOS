//
//  AXRuntimeInfomation.h
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLRequest+CTNetWorkingMethods.h"
#import "CTAPIBaseManager.h"
#import "QYUser.h"

@interface CTAppContext : NSObject

//凡是未声明成readonly的都是需要在初始化的时候由外面给的

// 设备信息
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *model;
@property (nonatomic, copy, readonly) NSString *os;
@property (nonatomic, copy, readonly) NSString *rom;
@property (nonatomic, copy, readonly) NSString *ppi;
@property (nonatomic, copy, readonly) NSString *imei;
@property (nonatomic, copy, readonly) NSString *imsi;
@property (nonatomic, copy, readonly) NSString *deviceName;
@property (nonatomic, assign, readonly) CGSize resolution;

@property (nonatomic, copy, readonly) NSString *deviceDetailMessage;
// 运行环境相关
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isOnline;

@property (nonatomic, strong) NSNumber *app_version;
@property (nonatomic, copy) NSString *onec_token;

// 用户token相关
@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, assign, readonly) NSTimeInterval lastRefreshTime;

//请求的sign;
@property (nonatomic, copy) NSString *sign;

// 用户信息
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, readonly) BOOL isLoggedIn;
@property (nonatomic, strong) QYUser *currentUser;
@property (nonatomic, strong) NSString *qiuniu_token;
@property (nonatomic, strong) NSNumber *timestamp;

// app信息
@property (nonatomic, copy, readonly) NSString *sessionId; // 每次启动App时都会新生成
@property (nonatomic, readonly) NSString *appVersion;

// 推送相关
@property (nonatomic, copy) NSData *deviceTokenData;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, strong) CTAPIBaseManager *updateTokenAPIManager;

// 地理位置
@property (nonatomic, assign, readonly) CGFloat latitude;
@property (nonatomic, assign, readonly) CGFloat longitude;

@property (nonatomic, strong) NSArray *functionArray;
@property (nonatomic, strong) NSArray *devceArray;
@property (nonatomic, strong) NSArray *cycleArray;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, strong) NSArray *slectCycleArray;
@property (nonatomic, strong) NSArray *slectFunctionArray;
@property (nonatomic, strong) UIImagePickerController *picker;
//html string
@property (nonatomic, strong) NSString *string;

//登录的用户
@property (nonatomic, assign) BOOL isFirstIn;

+ (instancetype)sharedInstance;

- (void)updateAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken;
- (void)cleanUserInfo;

- (void)appStarted;
- (void)appEnded;

-(void)updateCustomMessage:(NSArray *)array withKey:(NSString *)key;

-(void )configSelectArray;
-(void )configSelectCycleArray;
-(void )configSelectFunctionArray;
- (void)configQiuniuToken:(NSString *)qiuniu;

@end
