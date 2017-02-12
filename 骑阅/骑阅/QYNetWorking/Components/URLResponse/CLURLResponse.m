//
//  CLURLResponse.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/11.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CLURLResponse.h"
#import "NSObject+AXNetworkingMethods.h"
#import "NSURLRequest+CTNetWorkingMethods.h"

@interface CLURLResponse ()
@property (nonatomic, assign, readwrite) CTURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end
@implementation CLURLResponse

#pragma mark -life cycle

-(instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requstId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(CTURLResponseStatus)status {
    
    self = [super init];
    if (self) {
        
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requstId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        
    }
    
    return self;
}

-(instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requstId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error {
    
    
    self = [super init];
    if (self) {
        
        self.contentString = [responseString CT_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requstId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            
            self.content = nil;
        }
        
    }
    
    return self;
}

-(instancetype)initWithData:(NSData *)data {
    
    self = [super init];
    if (self) {
        
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    
    return self;
}



-(instancetype)initWith:(id)persistanceData {
    
    self = [super init];
    if (self) {
        
        self.content = persistanceData;
    }
    
    return self;
}

#pragma mark -private methods

-(CTURLResponseStatus)responseStatusWithError:(NSError *)error {
    
    if (error) {
        
        CTURLResponseStatus result = CTURLResponseStatusErrorNoNetwork;
        if (error.code == NSURLErrorTimedOut) {
            
            result = CTURLResponseStatusErrorTimeout;
        }
        return result;
    } else {
        
        return CTURLResponseStatusSuccess;
    }
}

@end
