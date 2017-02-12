//
//  YYService.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/14.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "YYService.h"
#import "CTAppContext.h"

@implementation YYService

@synthesize onlineApiVersion;
@synthesize serviceType;


-(BOOL)isOnline {
    
    return [CTAppContext sharedInstance].isOnline;
}

-(YYServiceType)type {
    
    return YYServiceTypeDefault;
}

//apiBaseUrl

-(NSString *)offlineApiBaseUrl {
    
    return @"http://app.api.autohome.com.cn/autov5.0.0";
}

-(NSString *)onlineApiBaseUrl {
    
    return @"http://app.api.autohome.com.cn/autov5.0.0";
}

//version
-(NSString *)offlineApiVersion {
    
    return @"";
}

-(NSString *)onlineApiVersionl {
    
    return @"";
}

//privateKey
-(NSString *)onlinePrivateKey {
    
    return @"";
}

-(NSString *)offlinePrivateKey {
    
    return @"";
}


//publicKey

-(NSString *)onlinePublickKey {
    
    return @"";
}

-(NSString *)offlinePublicKey {
    
    return @"";
}

@end
