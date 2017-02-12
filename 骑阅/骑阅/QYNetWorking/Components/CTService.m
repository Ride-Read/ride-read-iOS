//
//  CTService.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CTService.h"

@implementation CTService

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        if ([self conformsToProtocol:@protocol(CTServiceProtocal)]) {
            
            self.child = (id<CTServiceProtocal>)self;
        }
    }
    
    return self;
}

#pragma mark -getters and setters

-(YYServiceType)type {
    
    return self.child.serviceType;
}

-(NSString *)privateKey {
    
    return self.child.isOnline ? self.child.onlinePrivateKey:self.child.offlinePrivateKey;

}

-(NSString *)publickKey {
    
    return self.child.isOnline ? self.child.onlinePublickKey:self.child.offlinePublicKey;
}


-(NSString *)apiBaseUrl {
    
    return self.child.isOnline ? self.child.onlineApiBaseUrl:self.child.offlineApiBaseUrl;
}

-(NSString *)apiVersion {
    
    return self.child.isOnline ? self.child.onlineApiVersion:self.child.offlineApiVersion;

}

@end
