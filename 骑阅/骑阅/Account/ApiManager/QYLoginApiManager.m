//
//  QYLoginApiManager.m
//  骑阅
//
//  Created by 亮 on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginApiManager.h"

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
    
    return @"";
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
    
    return YES;
}

-(BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    
    return YES;
}

@end
