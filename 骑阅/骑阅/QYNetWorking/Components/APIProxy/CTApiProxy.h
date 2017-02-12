//
//  CTApiProxy.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLURLResponse.h"
typedef void(^AXCallback) (CLURLResponse *response);

@interface CTApiProxy : NSObject

+(instancetype)sharedInstance;

-(NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

-(NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

-(NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

-(NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

-(NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail;

-(NSInteger)callPOSTImageWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

-(void)cancelRequestWithRequestID:(NSNumber *)requestID;
-(void)cancelRequestWithRequestList:(NSArray *)requestIDList;

@end
