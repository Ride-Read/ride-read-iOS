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
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
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
    {
   
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObject:params[@"uuid"] forKey:@"uuid"];
//    //
//    //    [self.manager POST:string parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//    //        NSData *data = UIImagePNGRepresentation(avatar);
//    //        //NSData *data = UIImageJPEGRepresentation(avatar, 0.5);
//    //        [formData appendPartWithFileData:data name:@"avatar" fileName:@"youyueyizu" mimeType:@"image/png"];
//    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//    //        block(responseObject, nil);
//    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    //        block(nil, error);
//    //    }];
//    
//    [self.manager POST:string parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *data = UIImagePNGRepresentation(avatar);
//        [formData appendPartWithFileData:data name:@"avatar" fileName:@"youyueyizu" mimeType:@"image/png"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        block(responseObject, nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(nil, error);
//    }];
    }

}

#pragma mark -private methods

-(NSDictionary *)setRequetAuthenticaion:(NSDictionary *)params{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
//    static NSDateFormatter *formatter;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        formatter = [[NSDateFormatter alloc] init];
//        NSTimeZone *zone =  [[NSTimeZone alloc] init];
//        //NSArray *array = zone.knownTimeZoneNames;
//        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    });
//    NSDate *date = [formatter defaultDate];
//    NSTimeInterval interval = date.timeIntervalSince1970;
  
//    int rand = arc4random();
    NSString *timetamp = [NSString stringWithFormat:@"%lf",TimeStamp];
    NSString *token = [CTAppContext sharedInstance].currentUser.token;
    //NSString *sign = [NSString stringWithFormat:@"%@%@%@",timetamp,token,SALT];
   // sign = [NSString getMD5String:sign];
    //[dic setObject:timetamp?:@"error" forKey:@"timestamp"];
    [dic setObject:token?:@"error" forKey:@"token"];
    [dic setObject:timetamp forKey:@"timestamp"];
    //[dic setObject:sign?:@"error" forKey:@"sign"];
    return dic;
    
}
- (NSDictionary *)setRequestTimestamp:(NSDictionary *)params {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *timetamp = [NSString stringWithFormat:@"%lf",TimeStamp];
    [dic setObject:timetamp forKey:@"timestamp"];
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

@end
