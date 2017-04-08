//
//  QYAttentionReform.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAttentionReform.h"
#import "define.h"
#import "NSString+QYDateString.h"
#import "QYFansApiManager.h"
#import "QYFollowingApiManager.h"
#import "NSString+QYDateString.h"

@implementation QYAttentionReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    
    NSArray *users = data[kdata];
    NSMutableArray *result = @[].mutableCopy;
    if ([manager isKindOfClass:[QYFansApiManager class]]) {
        
        for (NSDictionary *info in users) {
            
            NSNumber *fid = info[kfid];
            NSString *username = info[@"follower_username"];
            NSString *sigature = info[@"follower_signature"];
            if ([sigature isKindOfClass:[NSNull class]]) {
                
                sigature = @"";
            }
            NSString *avater = info[@"follower_face_url"];
            NSNumber *time = info[kupdated_at];
            NSString *timeText = [NSString dateStringWithTime:time.doubleValue];
            NSMutableDictionary *user = @{kuid:fid,kusername:username?:@"",ksignature:sigature?:@"",kface_url:avater?:@"",ktime:timeText}.mutableCopy;
            [result addObject:user];
        }

    } else
    {
        
        for (NSDictionary *info in users) {
            
            NSNumber *fid = info[@"tid"];
            NSString *username = info[@"followed_username"];
            NSString *sigature = info[@"followed_signature"];
            NSString *avater = info[@"followed_face_url"];
            NSNumber *time = info[kupdated_at];
            if ([sigature isKindOfClass:[NSNull class]]) {
                
                sigature = @"";
            }
            NSString *timeText = [NSString dateStringWithTime:time.doubleValue];
            NSMutableDictionary *user = @{kuid:fid,kusername:username?:@"",ksignature:sigature?:@"",kface_url:avater?:@"",ktime:timeText}.mutableCopy;
            [result addObject:user];
        }
    }
    return result;
    
}
@end
