//
//  YYAuthenticationService.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/20.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "YYAuthenticationService.h"
#import "CTAppContext.h"

@implementation YYAuthenticationService

@synthesize serviceType;
@synthesize onlineApiVersion;

-(BOOL)isOnline {
    
    return [CTAppContext sharedInstance].isOnline;
}

-(YYServiceType)serviceType {
    
    return YYServiceTypeRequestAuthen;
}

//apiBaseUrl

-(NSString *)offlineApiBaseUrl {
    
    return @"http://121.42.195.113/rideread/";
}

-(NSString *)onlineApiBaseUrl {
    
    return @"http://121.42.195.113/rideread/";
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
