//
//  QYUserReform.m
//  骑阅
//
//  Created by chen liang on 2017/3/22.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUserReform.h"
#import "QYAddThumbApiManager.h"
#import "QYAddCommnetApiManager.h"
#import "QYRideUserApiManager.h"
#import "define.h"
#import "QYGetUsersInfoApiManager.h"
#import "QYPhoneCodeApiManager.h"

@implementation QYUserReform

- (id)logic:(CLAppLogic *)logic withTheManager:(CTAPIBaseManager *)manager reformData:(id)data {
    
    return data;
}

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    
    
    if ([manager isKindOfClass:[QYAddCommnetApiManager class]]) {
        
        NSDictionary *com = data[@"data"];
        NSNumber *reply_id = com[@"reply_uid"];
        NSMutableDictionary *comm = [NSMutableDictionary dictionaryWithDictionary:com];
        if (reply_id && ![reply_id isKindOfClass:[NSNull class]]) {
            
            comm[kmsg] = [NSString stringWithFormat:@"回复 %@:%@",comm[@"reply_username"]?:@"",comm[kmsg]];
            comm[kreply] = @{kuid:comm[@"reply_uid"],kusername:comm[@"reply_username"]?:@" "};
            
        }
        return comm;;
    }
    
    if ([manager isKindOfClass:[QYAddThumbApiManager class]]) {
        
        NSDictionary *thumb = data[kdata];
        if ([thumb isKindOfClass:[NSNull class]]) {
            
            return nil;
        }
        return thumb;
    }
    
    if ([manager isKindOfClass:[QYRideUserApiManager class]]) {
        
        NSDictionary *dict = data[kdata];
        QYUser *user = [QYUser userWithDict:dict];
        return user;
    }
    
    if ([manager isKindOfClass:[QYGetUsersInfoApiManager class]]) {
        
        NSArray *infos = data[kdata];
        NSMutableArray *result = @[].mutableCopy;
        for (NSDictionary *info in infos) {
            
            QYUser *user = [[QYUser alloc] init];
            user.uid = info[kuid];
            user.face_url = info[kface_url];
            user.username = info[kusername];
            [result addObject:user];
        }
        
        return result;
    }
    
    if ([manager isKindOfClass:[QYPhoneCodeApiManager class]]) {
        
        
        if (manager.errorType == CTAPIBaseManagerErrorTypeSuccess) {
            
            NSString *text = data[kdata][krand_code];
            return text;
            
        } else {
            
            NSString *msg = data[kmsg];
            return msg;
            
        }
    }
    return nil;
}
@end
