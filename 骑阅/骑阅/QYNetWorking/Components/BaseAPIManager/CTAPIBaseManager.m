//
//  CTAPIBaseManager.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/13.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CTAPIBaseManager.h"
#import "CTServiceFactory.h"
#import "CTApiProxy.h"
#import "CTAppContext.h"
#import "CTCache.h"
#import "CTNetworkingConfiguration.h"
#import <objc/runtime.h>

#define AXCallAPI(REQUEST_METHOD, REQUEST_ID)                                                   \
{                                                                                               \
__weak typeof(self) weakSelf = self;                                                        \
REQUEST_ID = [[CTApiProxy sharedInstance] call##REQUEST_METHOD##WithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(CTURLResponse *response) { \
__strong typeof(weakSelf) strongSelf = weakSelf;                                        \
[strongSelf successedOnCallingAPI:response];                                            \
} fail:^(CTURLResponse *response) {                                                        \
__strong typeof(weakSelf) strongSelf = weakSelf;                                        \
[strongSelf failedOnCallingAPI:response withErrorType:CTAPIManagerErrorTypeDefault];    \
}];                                                                                         \
[self.requestIdList addObject:@(REQUEST_ID)];                                               \
}

NSString * const kBSUserTokenInvalidNotifation = @"kBSUserTokenInvalidNotifation";
NSString * const kBSUserTokenIllegalNotificaiton = @"kBSUserTokenIllegalNotificaiton";
NSString * const kBSUserTokenNotificationUserTnfoKeyRequestToContinue = @"kBSUserTokenNotificationUserTnfoKeyRequestToContinue";
NSString * const kBSUserTokenNotificationUserInfoKeyManagerToContinue = @"kBSUserTokenNotificationUserInfoKeyManagerToContinue";
@interface CTAPIBaseManager ()

@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, assign) BOOL isNativeDataEmpty;
@property (nonatomic, assign ,readwrite) BOOL intereptorWhenLoadError;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) CTAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong) CTCache *cache;
@property (nonatomic, assign, readwrite) NSInteger requestId;

@end
@implementation CTAPIBaseManager

#pragma mark -life cycle
-(instancetype)init {
    
    if (self = [super init]) {
        
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        _errorType = CTAPIBaseManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(CTAPIManager)]) {
            
            self.child = (id <CTAPIManager>) self;
        } else {
            NSException *exception = [[NSException alloc] initWithName:@"inherit error" reason:@"inherit CTBaseApiManager must comply the CTAPIManager" userInfo:nil];
            @throw exception;
        }
        
        
    }
    
    return self;
}

-(void)dealloc {
    
#ifdef MYDEBUG
    NSLog(@"API 销毁:%@", object_getClass(self));
#endif
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark -public methods

-(void)cancelAllRequests {
    
    [[CTApiProxy sharedInstance] cancelRequestWithRequestList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

-(void)cancelRequestWithRequestId:(NSInteger)requestID {
    
    [self removeRequestIdWithRequestId:requestID];
    [[CTApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
    
}

-(id)fetchDataWithReformer:(id<CTAPIManagerDataReformer>)reformer {
    
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    
    return resultData;
}

#pragma mark -calling api

-(NSInteger)loadData {
    
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    self.requestId = requestId;
    return requestId;
}
-(NSInteger)loadDataWithParams:(NSDictionary *)params {
    
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    if ([self shouldCallAPIWithParams:apiParams]) {
        
        if ([self.validator manager:self isCorrectWithParamData:apiParams]) {
            
            if ([self shouldLoadFromNative]) {
                
                [self loadDataFromNative];
            }
            
            if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
                return 0;
            }
            
            if ([self isReachable]) {
                
                self.isLoading = YES;
                __weak typeof(self) weakSelf = self;
                switch (self.child.requestType) {
                    case CTAPIBaseManagerRequestTypeGet:
                    {
                       requestId = [[CTApiProxy sharedInstance] callGETWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(CLURLResponse *response) {
                           
                         __strong typeof(weakSelf) strongSelf = weakSelf;
                           [strongSelf successedOnCallingAPI:response];
                        } fail:^(CLURLResponse *response) {
                            
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            if (response.status == CTURLResponseStatusErrorTimeout) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeTimeOut];
                                return ;
                            }
                            
                            if (response.status == CTURLResponseStatusErrorNoNetwork) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeNoNetWork];
                                return;
                            }
                            [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeDefault];

                        }];
                    } break;
                    case CTAPIBaseManagerRequestTypePost:
                    {
                        
                       requestId = [[CTApiProxy sharedInstance] callPOSTWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(CLURLResponse *response) {
                           
                           __strong typeof(weakSelf) strongSelf = weakSelf;
                           [strongSelf successedOnCallingAPI:response];

                        } fail:^(CLURLResponse *response) {
                            
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            if (response.status == CTURLResponseStatusErrorTimeout) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeTimeOut];
                                return ;
                            }
                            
                            if (response.status == CTURLResponseStatusErrorNoNetwork) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeNoNetWork];
                                return;
                            }
                            [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeDefault];

                        }];
                        
                    }break;
                    case CTAPIBaseManagerRequestTypePut:
                    {
                        
                       requestId = [[CTApiProxy sharedInstance] callPUTWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(CLURLResponse *response) {
                           
                           __strong typeof(weakSelf) strongSelf = weakSelf;
                           [strongSelf successedOnCallingAPI:response];

                        } fail:^(CLURLResponse *response) {
                            
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            if (response.status == CTURLResponseStatusErrorTimeout) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeTimeOut];
                                return ;
                            }
                            
                            if (response.status == CTURLResponseStatusErrorNoNetwork) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeNoNetWork];
                                return;
                            }
                            [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeDefault];

                        }];
                    }break;
                    case CTAPIBaseManagerRequestTypeDelete:
                    {
                    requestId = [[CTApiProxy sharedInstance] callDELETEWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(CLURLResponse *response) {
                        
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        [strongSelf successedOnCallingAPI:response];

                     } fail:^(CLURLResponse *response) {
                         
                         __strong typeof(weakSelf) strongSelf = weakSelf;
                         if (response.status == CTURLResponseStatusErrorTimeout) {
                             
                             [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeTimeOut];
                             return ;
                         }
                         
                         if (response.status == CTURLResponseStatusErrorNoNetwork) {
                             
                             [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeNoNetWork];
                             return;
                         }
                         [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeDefault];

                    
                     }];
                        
                    }break;
                    case CTAPIBaseManagerRequestTypePostImage:{
                        
                        requestId = [[CTApiProxy sharedInstance] callPOSTImageWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(CLURLResponse *response) {
                            
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            [strongSelf successedOnCallingAPI:response];
                            
                        } fail:^(CLURLResponse *response) {
                            
                            __strong typeof(weakSelf) strongSelf = weakSelf;
                            if (response.status == CTURLResponseStatusErrorTimeout) {
                                
                                [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeTimeOut];
                                return ;
                            }
                            
                            if (response.status == CTURLResponseStatusErrorNoNetwork) {
                                
                                 [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeNoNetWork];
                                return;
                            }
                            [strongSelf failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeDefault];
                            
                        }];

                    }
                        
                    default:
                        break;
                }
                NSMutableDictionary *params = [apiParams mutableCopy];
                params[kCTAPIBaseManagerRequestID] = @(requestId);
                [self afterCallAPIWithParams:params];
                return requestId;
            } else {
                
                [self failedOnCallingAPI:nil withErrorType:CTAPIBaseManagerErrorTypeNoNetWork];
                return requestId;
            }
        } else {
            
            [self failedOnCallingAPI:nil withErrorType:CTAPIBaseManagerErrorTypeParamsError];
            return requestId;
        }
    }
    
    return requestId;
}

#pragma mark - api callbacks

-(void)successedOnCallingAPI:(CLURLResponse *)response {
    
    self.isLoading = NO;
    self.response = response;
    
    if ([self shouldLoadFromNative]) {
        
        if (response.isCache == NO) {
            
            [[NSUserDefaults standardUserDefaults] setObject:response.responseData forKey:self.child.methodName];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    if (response.content) {
        
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    
    [self removeRequestIdWithRequestId:response.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:response.content]) {
        if ([self shouldCache] && !response.isCache) {
            
            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
        }
        
        if ([self beforePerformSuccessWithResponse:response]) {
            
            if ([self shouldLoadFromNative]) {
                
                if (response.isCache == YES) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.delegate managerCallAPIDidSuccess:self];
                    });

                }
                if (self.isNativeDataEmpty) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.delegate managerCallAPIDidSuccess:self];
                    });

                }
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.delegate managerCallAPIDidSuccess:self];
                });

            }
        }
        [self afterPerformSuccessWithResponse:response];
    } else {
        
        [self failedOnCallingAPI:response withErrorType:CTAPIBaseManagerErrorTypeNoContent];
    }
    
    
}


-(void)failedOnCallingAPI:(CLURLResponse *)response withErrorType:(CTAPIManagerErrorType)type {
    
    self.isLoading = NO;
    self.response = response;
    if ([response.content[@"status"] isEqualToString:@"9999"]) {
        
        [self cancelAllRequests];
        [[NSNotificationCenter defaultCenter] postNotificationName:kBSUserTokenInvalidNotifation
                                                            object:nil
                                                          userInfo:@{kBSUserTokenNotificationUserTnfoKeyRequestToContinue:[response.request mutableCopy]
                                                                     ,kBSUserTokenNotificationUserInfoKeyManagerToContinue:self}];
    } else if ([response.content[@"id"] isEqualToString:@"illegal_access_token"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kBSUserTokenIllegalNotificaiton
                                                            object:nil
                                                          userInfo:@{kBSUserTokenNotificationUserTnfoKeyRequestToContinue:[response.request mutableCopy]
                                                                     ,kBSUserTokenNotificationUserInfoKeyManagerToContinue:self}];
    } else if ([response.content[@"id"] isEqualToString:@"no_permission_for_this_api"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kBSUserTokenIllegalNotificaiton object:nil userInfo:@{kBSUserTokenNotificationUserTnfoKeyRequestToContinue:[response.request mutableCopy]
                                                                                                                         ,kBSUserTokenNotificationUserInfoKeyManagerToContinue:self}];
    } else {
        
        self.errorType = type;
        [self removeRequestIdWithRequestId:response.requestId];
        if ([self beforePerformFailWithResponse:response]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate managerCallAPIDidFailed:self];
            });

        } 
        
        [self afterPerformFailWithResponse:response];
    }
    
    
}

#pragma mark -method for interceptor


-(BOOL)beforePerformSuccessWithResponse:(CLURLResponse *)response {
    
    BOOL result = YES;
    self.errorType = CTAPIBaseManagerErrorTypeSuccess;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        
        result = [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
    
    return result;
}

-(void)afterPerformSuccessWithResponse:(CLURLResponse *)response {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

-(BOOL)beforePerformFailWithResponse:(CLURLResponse *)response {
    
    BOOL result = YES;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        
        result = [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
    
    return result;
}

-(void)afterPerformFailWithResponse:(CLURLResponse *)response {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

-(BOOL)shouldCallAPIWithParams:(NSDictionary *)parsms {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        
        return [self.interceptor manager:self shouldCallAPIWithParams:parsms];
    } else {
        
        return YES;
    }
}

-(void)afterCallAPIWithParams:(NSDictionary *)parsms {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallAPIWithParams:)]) {
        
        [self.interceptor manager:self afterCallAPIWithParams:parsms];
    }
}

#pragma mark -method for chid

-(void)cleadData {
    
    [self.cache clean];
    self.fetchedRawData = nil;
    self.errorMessage = nil;
    self.errorType = CTAPIBaseManagerErrorTypeDefault;
}

//如何需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params];
-(NSDictionary *)reformParams:(NSDictionary *)params {
    
    
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self.child methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        
        return params;
    } else {
        
        //如何child使继承来的，那么这里就不会跑到，会直接跑子类中的IMP
        //如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

-(BOOL)shouldCache {
    
    return kCTShouldCache;
}

#pragma mark -private methods
-(void)removeRequestIdWithRequestId:(NSInteger)requestId {
    
    NSNumber *requestIdToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        
        if ([storedRequestId integerValue] == requestId) {
            
            requestIdToRemove = storedRequestId;
        }
    }
    
    if (requestIdToRemove) {
        
        [self.requestIdList removeObject:requestIdToRemove];
    }
}

-(BOOL)hasCacheWithParams:(NSDictionary *)params {
    
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache fetchCachedDataWithServiceIdetifier:serviceIdentifier methodName:methodName requestParams:params];
    if (result == nil) {
        
        return NO;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CLURLResponse *response = [[CLURLResponse alloc] initWithData:result];
        response.requestParams  = params;
        [strongSelf successedOnCallingAPI:response];
    });
    return YES;
}

-(void)loadDataFromNative {
    
    NSString *methodName = self.child.methodName;
    NSDictionary *result = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:methodName];
    if (result) {
        
        self.isNativeDataEmpty = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
           
            __strong typeof(weakSelf) strongSelf = weakSelf;
            CLURLResponse *response = [[CLURLResponse alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:NULL]];
            [strongSelf successedOnCallingAPI:response];
        });
    } else {
        
        self.isNativeDataEmpty = YES;
    }
    
}

#pragma mark -getters and setters
-(CTCache *)cache {
    
    if (!_cache) {
        
        _cache = [CTCache sharedInstance];
    }
    return _cache;
}

-(NSMutableArray *)requestIdList {
    
    if (_requestIdList == nil) {
        
        _requestIdList = [[NSMutableArray alloc] init];
    }
    
    return _requestIdList;
}

-(BOOL)isReachable {
    
    BOOL isReachability = [CTAppContext sharedInstance].isReachable;
    if (!isReachability) {
        
        self.errorType = CTAPIBaseManagerErrorTypeNoNetWork;
    }
    
    return isReachability;
}
-(BOOL)isLoading {
    
    if (self.requestIdList.autoContentAccessingProxy == 0) {
        
        _isLoading = NO;
    }
    
    return _isLoading;
}

-(BOOL)shouldLoadFromNative {
    
    return NO;
}


@end

