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
#import "NSString+QYRegular.h"

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
    
    NSString *nickname = params[kusername];
    if (nickname.length > 0)
    nickname = [NSString encodeString:nickname];
    NSString *phone = params[kphonenumber];
    NSString *url = params[kface_url];
    NSString *ride_id = params[kride_read_id];
    url = [Basic_Qiniu_URL stringByAppendingString:url];
    NSString *pwd = params[kpassword];
    if (pwd.length > 0) {
        
       pwd =  [pwd sha1];
    }
    return @{kusername:nickname,kphonenumber:phone,kface_url:url,kpassword:pwd,kride_read_id:ride_id};
}

#pragma mark - APIManagerValidator
-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    NSString *nickname = data[kusername];
    NSString *url = data[kface_url];
    NSString *pwd = data[kpassword];
    NSString *phone = data[kphonenumber];
    NSString *ride_id = data[kride_read_id];
    BOOL correct =  [ride_id checkRide_read_id];
    if (!correct)
        return NO;
    if (nickname.length <= 0 || url.length <= 0 || pwd.length < 6||phone.length < 11||ride_id.length < 3) {
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
