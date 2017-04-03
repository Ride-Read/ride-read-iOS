//
//  QYLoginApiManager.m
//  骑阅
//
//  Created by 亮 on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginApiManager.h"
#import "define.h"
#import "NSString+QYMD5.h"

@interface QYLoginApiManager ()<CTAPIManagerValidator>

@end
@implementation QYLoginApiManager

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
    
    return @"users/login";
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
-(NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSString *userName = params[kphonenumber];
    NSString *password = params[kpassword];
    NSNumber *latitue = params[klatitude];
    NSString *longtitue = params[klongitude];
    NSDictionary *dict;
    if (password.length > 0) {
        
        password = [password sha1];
        
    }
    dict = @{kphonenumber:userName,kpassword:password,klongitude:longtitue,klatitude:latitue};
    
    return dict;
}


#pragma mark - APIManagerValidator
-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    NSString *userName = data[kphonenumber];
    NSString *password = data[kpassword];
    if (!userName||userName.length <= 0) {
        
        return NO;
    }
    if (password.length <= 0) {
        
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
