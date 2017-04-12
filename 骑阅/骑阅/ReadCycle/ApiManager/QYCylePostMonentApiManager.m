//
//  QYCylePostMonentApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCylePostMonentApiManager.h"
#import "define.h"
#import "NSString+QYUrlEncode.h"

@interface QYCylePostMonentApiManager ()<CTAPIManagerValidator>

@end
@implementation QYCylePostMonentApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    return self;
}

- (NSString *)methodName {
    
    return @"moments/post_moment";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}

- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}
- (BOOL)shouldCache {
    
    return NO;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    
    NSString *msg = params[kmsg];
    //msg = [NSString encodeString:msg];
    NSNumber *uid = params[kuid];
    NSInteger type = 0;
    NSString *video = params[kvideo_url];
    NSNumber *longitude = params[klongitude];
    NSNumber *latitude = params[klatitude];
    if (video) {
        type = 2;
        NSString *cover = params[kcover];
        return @{kuid:uid,kmsg:msg,kvideo_url:video,kcover:cover,ktype:@(type),klatitude:latitude,klongitude:longitude};
    }
    NSArray *pictures = params[kpictures_url];
    NSString *picture = [pictures componentsJoinedByString:@","];
    if (pictures.count > 0) {
        type = 1;
        return @{kmoment_location:@"深圳",kuid:uid,kmsg:msg,kpictures_url:picture,ktype:@(type),klatitude:latitude,klongitude:longitude};
    }
    
    return @{kuid:uid,kmsg:msg,ktype:@(type),klatitude:latitude,klongitude:longitude};
}

#pragma mark - CTAPIValidator

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    NSString *msg = data[kmsg];
    NSNumber *uid = data[kuid];
    if (msg.length <= 0) {
        
        return NO;
    }
    if (!uid) {
        
        return NO;
    }
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    NSNumber *status = data[kstatus];
    if (status.integerValue == 0) {
        
        return YES;
    }
    return NO;
    
}

@end
