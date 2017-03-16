//
//  QYUserRegisterApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUserRegisterApiManager.h"
#import "define.h"
#import "NSString+QYMD5.h"


@interface QYUserRegisterApiManager ()<CTAPIManagerValidator>

@end

@implementation QYUserRegisterApiManager

#pragma mark - life cycle
-(instancetype)init {
    
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark -APIManager
-(NSString *)methodName {
    
    return @"users/register";
}

-(NSString *)serviceType {
    
    return kCTServiceYY;
}

-(CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}

-(BOOL)shouldCache {
    
    return NO;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSString *nickname = params[knickname];
    if (nickname.length > 0)
    nickname = [NSString encodeString:nickname];
    NSString *phone = params[kphonenumber];
    NSString *url = params[kface_url];
    url = [Basic_Qiniu_URL stringByAppendingString:url];
    NSString *pwd = params[kpassword];
    if (pwd.length > 0) {
        
       pwd =  [pwd sha1];
    }
    return @{knickname:nickname,kphonenumber:phone,kface_url:url,kpassword:pwd};
}

#pragma mark - APIManagerValidator
-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    NSString *nickname = data[knickname];
    NSString *url = data[kface_url];
    NSString *pwd = data[kpassword];
    NSString *phone = data[kphonenumber];
    if (nickname.length <= 0 || url.length <= 0 || pwd.length < 6||phone.length < 11) {
        return NO;
    }
    
    return YES;
}

-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    
    NSNumber *status = data[kstatus];
    if (status.integerValue == 0) {
        
        return YES;
    }
    return NO;
}

@end
