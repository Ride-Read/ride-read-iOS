//
//  CLURLResponse.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/11.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTNetworkingConfiguration.h"


@interface CLURLResponse : NSObject

@property (nonatomic, assign, readonly) CTURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy) NSDictionary *requestParams;

@property (nonatomic, assign, readonly) BOOL isCache;


-(instancetype)initWithResponseString:(NSString *)responseString
                            requestId:(NSNumber *)requstId
                              request:(NSURLRequest *)request
                         responseData:(NSData *)responseData status:(CTURLResponseStatus)status;

-(instancetype)initWithResponseString:(NSString *)responseString
                            requestId:(NSNumber *)requstId
                              request:(NSURLRequest *)request
                         responseData:(NSData *)responseData error:(NSError *)error;


//缓存数据进行初始化
-(instancetype)initWithData:(NSData *)data;

//用持久层数据进行初始化
-(instancetype)initWith:(id)persistanceData;

@end
