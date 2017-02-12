//
//  YYWeiXinServce.m
//  优悦一族
//
//  Created by 亮 on 16/10/8.
//  Copyright © 2016年 umed. All rights reserved.
//

#import "YYWeiXinServce.h"
#import "CTAppContext.h"

@implementation YYWeiXinServce

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
    
    return @"https://api.weixin.qq.com/sns";
}

-(NSString *)onlineApiBaseUrl {
    
    return @"https://api.weixin.qq.com/sns";
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
