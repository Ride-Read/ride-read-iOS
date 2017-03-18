//
//  YYJsonService.m
//  骑阅
//
//  Created by chen liang on 2017/3/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "YYJsonService.h"
#import "define.h"

@implementation YYJsonService

@synthesize serviceType;
@synthesize onlineApiVersion;

-(BOOL)isOnline {
    
    return [CTAppContext sharedInstance].isOnline;
}

-(YYServiceType)serviceType {
    
    return YYServiceTypeRequstJsonEncode;
}

//apiBaseUrl

-(NSString *)offlineApiBaseUrl {
    
    return @"http://121.42.195.113:3000";
}

-(NSString *)onlineApiBaseUrl {
    
    return @"http://121.42.195.113:3000";
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
