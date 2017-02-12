//
//  CTCache.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CTCache.h"
#import "NSDictionary+AXNetworkingMethods.h"
#import "CTNetworkingConfiguration.h"


@interface CTCache ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation CTCache

#pragma mark -getters and setters

-(NSCache *)cache {
    
    if (_cache == nil) {
        
        _cache = [[NSCache  alloc] init];
        _cache.countLimit = kCTCacheCountLimit;
    }
    
    return _cache;
}

#pragma mark -life cycle

+(instancetype)sharedInstance {
    
    
    static dispatch_once_t onceToken;
    static CTCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[CTCache alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark -public method
-(NSData *)fetchCachedDataWithServiceIdetifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

-(NSData *)fetchCachedDataWithKey:(NSString *)key {
    
    CTCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmty) {
        
        return nil;
    } else {
        return cachedObject.content;
    }
 
}

-(void)saveCacheWithData:(NSData *)cachedData serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

-(void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key {
    
    CTCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject == nil) {
        
        cachedObject = [[CTCachedObject alloc] init];
    }
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
    
}

-(void)deleteCacheWithServiceIdentifer:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    
    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

-(void)deleteCacheWithKey:(NSString *)key {
    
    [self.cache removeObjectForKey:key];
}

-(void)clean {
    
    [self.cache removeAllObjects];
}

-(NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    //warning 这里是因为timestamp，是根据当前时间传入的，所以要去掉这个键值对，不然缓存不能起到作用
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    if (serviceIdentifier == kCTServiceAuthonticationYY) {
        
        [params removeObjectForKey:@"timestamp"];
        [params removeObjectForKey:@"sign"];
        [params removeObjectForKey:@"token"];
    }
    return [NSString stringWithFormat:@"%@%@%@",serviceIdentifier,methodName,[params CT_urlParamsStringSignature:NO]];
    
}

#pragma mark - private method

@end
