//
//  CLRequestGenerator.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/13.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CLRequestGenerator.h"
#import "CTServiceFactory.h"
#import "NSDictionary+AXNetworkingMethods.h"
#import "CTNetworkingConfiguration.h"
#import "CTService.h"
#import "NSObject+AXNetworkingMethods.h"
#import "AFURLRequestSerialization.h"
#import "NSURLRequest+CTNetWorkingMethods.h"
#import "CTAppContext.h"
#import "NSString+AXNetworkingMethods.h"



#define TimeStamp [[NSDate date] timeIntervalSince1970]
#define SALT @"qwertyasdfgzxcvb12345"

@interface CLRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequstSerializer;
@end
@implementation CLRequestGenerator

#pragma mark -publick methods

+(instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static CLRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    
    CTService *service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdetifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        
        urlString = [NSString stringWithFormat:@"%@/%@/%@",service.apiBaseUrl,service.apiVersion,methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@",service.apiBaseUrl,methodName];
    }
    if (service.type == YYServiceTypeRequestAuthen) {
        
        requestParams = [self setRequetAuthenticaion:requestParams];
        
    } else {
        
        requestParams = [self setRequestTimestamp:requestParams];
    }
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
    if ([CTAppContext sharedInstance].accessToken) {
        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    return request;
}


-(NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    CTService *service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdetifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        
        urlString = [NSString stringWithFormat:@"%@/%@/%@",service.apiBaseUrl,service.apiVersion,methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@",service.apiBaseUrl,methodName];
    }
    
    if (service.type == YYServiceTypeRequestAuthen) {
        
       requestParams = [self setRequetAuthenticaion:requestParams];
    } else {
        
        requestParams = [self setRequestTimestamp:requestParams];
    }
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    NSMutableURLRequest *request;
    if (service.type ==  YYServiceTypeRequstJsonEncode) {
        
        request = [self.jsonRequstSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    } else {
        
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    }
    if ([CTAppContext sharedInstance].accessToken) {
        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;
}


-(NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    CTService *service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdetifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    if (service.type == YYServiceTypeRequestAuthen) {
        
        requestParams = [self setRequetAuthenticaion:requestParams];
    } else {
        
        requestParams = [self setRequestTimestamp:requestParams];
    }
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([CTAppContext sharedInstance].accessToken) {
        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;

}

-(NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    CTService *service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdetifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    if (service.type == YYServiceTypeRequestAuthen) {
        
        requestParams = [self setRequetAuthenticaion:requestParams];
    } else {
        
        requestParams = [self setRequestTimestamp:requestParams];
    }
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([CTAppContext sharedInstance].accessToken) {
        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;
}

-(NSURLRequest *)generateImageRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    NSString *kimage ;
    if (requestParams[@"img"])
        kimage = @"img";
    else
        kimage = @"avatar";

    NSString *uuid;
    if (requestParams[@"uuid"])
        uuid = @"uuid";
    else
        uuid = @"subuuid";
    
    NSData *image = requestParams[kimage];
    CTService *service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdetifier];
    
    if (service.type == YYServiceTypeRequestAuthen) {
        
        requestParams = [self setRequetAuthenticaion:requestParams];
        
    } else {
        
        requestParams = [self setRequestTimestamp:requestParams];
    }
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        
        urlString = [NSString stringWithFormat:@"%@/%@/%@",service.apiBaseUrl,service.apiVersion,methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@",service.apiBaseUrl,methodName];
    }

    NSString *string = [NSString stringWithFormat:@"%@?token=%@&timestamp=%@&sign=%@",urlString,requestParams[@"token"],requestParams[@"timestamp"],requestParams[@"sign"]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:string parameters:@{uuid:requestParams[uuid]} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        [formData appendPartWithFileData:image name:kimage fileName:@"youyueyizu" mimeType:@"image/png"];

    } error:nil];
    return request;

}

#pragma mark -private methods

-(NSDictionary *)setRequetAuthenticaion:(NSDictionary *)params{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    NSNumber *timetamp = [CTAppContext sharedInstance].timestamp;
    NSString *token = [CTAppContext sharedInstance].currentUser.token;
    [dic setObject:token?:@"error" forKey:@"token"];
    [dic setObject:@(timetamp.integerValue) forKey:@"timestamp"];
    return dic;
    
}
- (NSDictionary *)setRequestTimestamp:(NSDictionary *)params {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *timetamp = [NSString stringWithFormat:@"%lf",TimeStamp * 1000];
    [dic setObject:@(timetamp.integerValue) forKey:@"timestamp"];
    return dic;

}

#pragma mark - getters and setters
-(AFHTTPRequestSerializer *)httpRequestSerializer {
    
    if (!_httpRequestSerializer) {
        
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kCTNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    
    return _httpRequestSerializer;
}

- (AFJSONRequestSerializer *)jsonRequstSerializer {
    
    if (!_jsonRequstSerializer) {
        
        _jsonRequstSerializer = [AFJSONRequestSerializer serializer];
        _jsonRequstSerializer.timeoutInterval = kCTNetworkingTimeoutSeconds;
        _jsonRequstSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _jsonRequstSerializer;
}

@end
