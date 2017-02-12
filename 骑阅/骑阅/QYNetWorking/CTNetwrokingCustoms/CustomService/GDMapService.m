//
//  GDMapService.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "GDMapService.h"

@implementation GDMapService

@synthesize serviceType;
@synthesize onlineApiVersion;

-(YYServiceType)type {
    
    return YYServiceTypeDefault;
}
-(BOOL)isOnline {
    
    return YES;
}

-(NSString *)offlinePublicKey {
    
    return @"384ecc4559ffc3b9ed1f81076c5f8424";
}

-(NSString *)onlinePublickKey {
    
    return @"384ecc4559ffc3b9ed1f81076c5f8424";
}

-(NSString *)offlinePrivateKey {
    
    return @"";
}

-(NSString *)onlinePrivateKey {
    
    return @"";
}

-(NSString *)offlineApiBaseUrl {
    
    return @"http://restapi.amap.com";
}

-(NSString *)onlineApiBaseUrl {
    
    return @"http://restapi.amap.com";
}

-(NSString *)offlineApiVersion {
    
    return @"v3";
}

-(NSString *)onlineApiVersionl {
    
    return @"v3";
}


@end
