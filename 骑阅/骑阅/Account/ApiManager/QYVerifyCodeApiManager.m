//
//  QYVerifyCodeApiManager.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYVerifyCodeApiManager.h"
#import "define.h"


@interface QYVerifyCodeApiManager ()<CTAPIManagerValidator>

@end
@implementation QYVerifyCodeApiManager

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
    
    return @"users/verify";
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
    
    NSString *code = data[kusername];
    if (!code||code.length < 3) {
        
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
