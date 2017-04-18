//
//  QYCycleCollectReform.m
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleCollectReform.h"
#import "define.h"
#import "NSString+QYDateString.h"

@implementation QYCycleCollectReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    
    NSArray *array = data[kdata];
    NSMutableArray *result = @[].mutableCopy;
    for (NSDictionary *info in array) {
        

        NSString *msg = info[kmsg];
        if ([msg isKindOfClass:[NSNull class]]) {
            
            msg = @"";
        }
        NSNumber *mid = info[kmid];
        NSNumber *uid = info[kuid];
        NSString *cover = info[@"first_picture"];
        if ([cover isKindOfClass:[NSNull class]]) {
            
            cover = @"";
        }
        NSString *username = info[kusername];
        NSNumber *timeNu = info[@"update_at"];
        NSString *time = [NSString dateStringWithTime:timeNu.doubleValue];
        NSNumber *type = info[ktype];
        NSString *face_url = info[kface_url];
        if ([face_url isKindOfClass:[NSNull class]]) {
            
            face_url = @"";
        }
        NSString *from;
        if (type.integerValue == 1) {
            
            from = @"关注";
        }
        
        if (type.integerValue == 2) {
            
            from = @"粉丝";
        }
        
        if (type.integerValue == 3) {
            
            from = @"附近";
        }
        if (type.integerValue == 0) {
            
            from = @"自己";
        }
        
        [result addObject:@{kface_url:face_url?:@"",kuid:uid,kmid:mid,kmsg:msg?:@"",kcover:cover?:@"",ktime:time,kfrom:from,kusername:username}];
        
    }
    return result;
    
}
@end
