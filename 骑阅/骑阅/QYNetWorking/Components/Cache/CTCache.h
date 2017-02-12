//
//  CTCache.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTCachedObject.h"

@interface CTCache : NSObject

+(instancetype)sharedInstance;

-(NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams;

-(NSData *)fetchCachedDataWithServiceIdetifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams;

-(void)deleteCacheWithServiceIdentifer:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams;

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;

-(NSData *)fetchCachedDataWithKey:(NSString *)key;
-(void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key;
-(void)deleteCacheWithKey:(NSString *)key;
-(void)clean;

@end
