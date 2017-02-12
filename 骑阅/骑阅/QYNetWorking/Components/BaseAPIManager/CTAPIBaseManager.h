//
//  CTAPIBaseManager.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/13.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLURLResponse.h"
#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * const  kBSUserTokenInvalidNotifation;
UIKIT_EXTERN NSString * const kBSUserTokenNotificationUserTnfoKeyRequestToContinue;
UIKIT_EXTERN NSString * const kBSUserTokenNotificationUserInfoKeyManagerToContinue;
@class CTAPIBaseManager;

static NSString * const kCTAPIBaseManagerRequestID = @"kCTAPIBaseManagerRequestID";

@protocol CTAPIManagerCallBackDelegate <NSObject>

@required
-(void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager;
-(void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager;
@end



@protocol CTAPIManagerDataReformer <NSObject>
@required
-(id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data;

@end

@protocol CTAPIManagerValidator <NSObject>

@required
-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data;

@end

@protocol CTAPIManagerParamSource <NSObject>

@required
-(NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager;

@end

typedef NS_ENUM(NSUInteger,CTAPIManagerErrorType) {
    
    CTAPIBaseManagerErrorTypeDefault,//没有产生API请求，这个是manager的默认状态
    CTAPIBaseManagerErrorTypeSuccess,//API请求成功返回数据正确，此时manager的数据是可以直接拿来使用的
    CTAPIBaseManagerErrorTypeNoContent,//API请求成功但返回数据不正确，如果回调验证函数返回值为NO，manager状态就是这个
    CTAPIBaseManagerErrorTypeParamsError,//参数错误，此时manager不会调用API，因为参数验证是在API调用之前的
    CTAPIBaseManagerErrorTypeTimeOut,//请求超时，CTAPIProxy设置的是20秒超时，具体超时时间在设置请
    CTAPIBaseManagerErrorTypeNoNetWork //网络不通，在调用API之前会判断一下当前网络是否畅通，这个也是调用API之前验证的，和超时有区别。
};

typedef NS_ENUM(NSUInteger,CTAPIManagerRequestType) {
    
    CTAPIBaseManagerRequestTypeGet,
    CTAPIBaseManagerRequestTypePost,
    CTAPIBaseManagerRequestTypePut,
    CTAPIBaseManagerRequestTypeDelete,
    CTAPIBaseManagerRequestTypePostImage
};


@protocol CTAPIManager <NSObject>

@required
-(NSString *)methodName;
-(NSString *)serviceType;
-(CTAPIManagerRequestType)requestType;
-(BOOL)shouldCache;

@optional
-(void)cleanData;
-(NSDictionary *)reformParams:(NSDictionary *)params;
-(NSDictionary *)loadDataWithParams:(NSDictionary *)params;
-(BOOL)shouldLoadFromNative;

@end

@protocol CTAPIManagerInterceptor <NSObject>

@optional
-(BOOL)manager:(CTAPIBaseManager *)manager beforePerformSuccessWithResponse:(CLURLResponse *)response;
-(void)manager:(CTAPIBaseManager *)manager afterPerformSuccessWithResponse:(CLURLResponse *)response;

-(BOOL)manager:(CTAPIBaseManager *)manager beforePerformFailWithResponse:(CLURLResponse *)response;
-(void)manager:(CTAPIBaseManager *)manager afterPerformFailWithResponse:(CLURLResponse *)response;

-(BOOL)manager:(CTAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)parsms;

-(void)manager:(CTAPIBaseManager *)manager afterCallAPIWithParams:(NSDictionary *)parsms;
@end

@interface CTAPIBaseManager : NSObject

@property (nonatomic, weak) id<CTAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<CTAPIManagerParamSource> paramSource;
@property (nonatomic, weak) id<CTAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<CTAPIManager> *child;
@property (nonatomic, weak) id<CTAPIManagerInterceptor> interceptor;

@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) CTAPIManagerErrorType errorType;
@property (nonatomic, strong) CLURLResponse *response;

@property (nonatomic, assign ,readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, assign, readonly) BOOL intereptorWhenLoadError;
@property (nonatomic, assign, readonly) NSInteger requestId;//这个标记主要用来判断当次请求结果是否为本次请求的 //这个是没有用的不能进行判断

-(id)fetchDataWithReformer:(id<CTAPIManagerDataReformer>)reformer;

-(NSInteger)loadData;

-(void)cancelAllRequests;
-(void)cancelRequestWithRequestId:(NSInteger)requestID;

-(BOOL)beforePerformSuccessWithResponse:(CLURLResponse *)response;
-(void)afterPerformSuccessWithResponse:(CLURLResponse *)response;

-(BOOL)beforePerformFailWithResponse:(CLURLResponse *)response;
-(void)afterPerformFailWithResponse:(CLURLResponse *)response;

-(BOOL)shouldCallAPIWithParams:(NSDictionary *)parsms;
-(void)afterCallAPIWithParams:(NSDictionary *)parsms;


-(NSDictionary *)reformParams:(NSDictionary *)params;
-(void)cleadData;
-(BOOL)shouldCache;

-(void)successedOnCallingAPI:(CLURLResponse *)response;
-(void)failedOnCallingAPI:(CLURLResponse *)response withErrorType:(CTAPIManagerErrorType)type;

@end
