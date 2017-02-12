//
//  CLRequestGenerator.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/13.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRequestGenerator : NSObject

+(instancetype)sharedInstance;

-(NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
-(NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
-(NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
-(NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
-(NSURLRequest *)generateImageRequestWithServiceIdentifier:(NSString *)serviceIdetifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;


@end
