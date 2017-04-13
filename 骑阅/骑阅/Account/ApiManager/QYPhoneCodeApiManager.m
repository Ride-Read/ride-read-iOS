//
//  QYPhoneCodeApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/4/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPhoneCodeApiManager.h"
#import "define.h"
#import "NSString+QYRegular.h"

@interface QYPhoneCodeApiManager ()<CTAPIManagerValidator>

@end

@implementation QYPhoneCodeApiManager
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
    
    return @"util/yun_pian_code";
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

#pragma mark - APIManagerValidator
-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    NSString *code = data[kphonenumber];
    if (![code checkPhoneText]) {
        
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
