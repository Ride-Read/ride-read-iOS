//
//  CTApiProxy.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CTApiProxy.h"
#import "AFNetworking.h"
#import "CTServiceFactory.h"
#import "NSURLRequest+CTNetWorkingMethods.h"
#import "CLRequestGenerator.h"
#import "CLURLResponse.h"
#import "CTLogger.h"

static NSString * const kAXApiProxyDispatchItemKeyCallbackSuccess = @"kAXApiProxyDispatchItemKeyCallbackSuccess";
static NSString * const kAXApiProxyDispatchItemKeyCallbackFail = @"kAXApiProxyDispatchItemKeyCallbackFail";

@interface CTApiProxy ()
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end
@implementation CTApiProxy

#pragma mark -getter and setter

-(NSMutableDictionary *)dispatchTable {
    
    if (!_dispatchTable) {
        
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    
    return _dispatchTable;
}

-(AFHTTPSessionManager *)sessionManager {
    
    
    if (!_sessionManager) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
    }
    
    return _sessionManager;
}

#pragma mark -life cycle

+(instancetype)sharedInstance {
    
    static CTApiProxy *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[CTApiProxy alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark -public methods

-(NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    
    NSURLRequest *request = [[CLRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

-(NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    
    NSURLRequest *request = [[CLRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

-(NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    
    NSURLRequest *request = [[CLRequestGenerator sharedInstance] generatePutRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

-(NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    
    NSURLRequest *request = [[CLRequestGenerator sharedInstance] generateDeleteRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

-(NSInteger)callPOSTImageWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    
    NSURLRequest *request = [[CLRequestGenerator sharedInstance] generateImageRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
    
}

-(void)cancelRequestWithRequestID:(NSNumber *)requestID {
    
    NSURLSessionDataTask *task = self.dispatchTable[requestID];
    [task cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

-(void)cancelRequestWithRequestList:(NSArray *)requestIDList {
    
    for (NSNumber *requestId in requestIDList) {
        
        [self cancelRequestWithRequestID:requestId];
    }
}


-(NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail {
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
        
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (error) {
            
            [CTLogger logDebugInfoWithResponse:httpResponse resposeString:responseString request:request error:error];
            CLURLResponse *response = [[CLURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            fail?fail(response):nil;
        } else {
            
            [CTLogger logDebugInfoWithResponse:httpResponse resposeString:responseString request:request error:NULL];
            CLURLResponse *response = [[CLURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:CTURLResponseStatusSuccess];
            success?success(response):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}





@end
