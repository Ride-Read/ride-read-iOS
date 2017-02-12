//
//  YYWeiBoServce.m
//  优悦一族
//
//  Created by 亮 on 16/10/8.
//  Copyright © 2016年 umed. All rights reserved.
//

#import "YYWeiBoServce.h"
#import "CTAppContext.h"

@implementation YYWeiBoServce

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
    
    return @"http://120.76.99.63:8080/youyueyizu_api";
}

-(NSString *)onlineApiBaseUrl {
    
    return @"http://192.168.199.120:8080/youyueyizu_api";
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
