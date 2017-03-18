//
//  CTServiceFactory.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CTServiceFactory.h"
#import "YYService.h"
#import "GDMapService.h"
#import "YYAuthenticationService.h"
#import "YYJsonService.h"

// service name list
NSString *const kCTServiceGDMapV3 = @"kCTServiceGDMapV3";
NSString *const kCTServiceYY = @"kCTServiceYY";
NSString *const kCTServiceAuthonticationYY = @"kCTServiceAuthonticationYY";
NSString *const kCTJsonService = @"kCTJsonService";
@interface CTServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;
@end
@implementation CTServiceFactory

#pragma mark -getters and setters

-(NSMutableDictionary *)serviceStorage {
    
    if (_serviceStorage == nil) {
        
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    
    return _serviceStorage;
}

#pragma mark -life cycle

+(instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static CTServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[CTServiceFactory alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark -public methods;

-(CTService<CTServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier {
    
    if (self.serviceStorage[identifier] == nil) {
        
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    
    return self.serviceStorage[identifier];
    
}

#pragma mark -private methods

-(CTService<CTServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier {
    
    if ([identifier isEqualToString:kCTServiceGDMapV3]) {
        
        return [[GDMapService alloc] init];
    }
    
    if ([identifier isEqualToString:kCTServiceYY]) {
        
        return [[YYService alloc] init];
        
    }
    
    if ([identifier isEqualToString:kCTServiceAuthonticationYY]) {
        
        return [[YYAuthenticationService alloc] init];
    }
    
    if ([identifier isEqualToString:kCTJsonService]) {
        
        return [[YYJsonService alloc] init];
    }
    
    return nil;
}

@end
