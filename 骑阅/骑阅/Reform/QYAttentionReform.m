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

@implementation QYAttentionReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    QYUser *user = [CTAppContext sharedInstance].currentUser;
    NSDictionary *info = [CTAppContext sharedInstance].userInfo;
    NSNumber *time = user.created_at;
    NSString *timeString = [NSString dateStringWithTime:time.doubleValue];
    return @[@{kdata:user,@"result":@{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString}},
             @{kdata:user,@"result":@{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString}},
             @{kdata:user,@"result":@{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString}},
             @{kdata:user,@"result":@{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString}},
             @{kdata:user,@"result":@{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString}}];
//    return @[@{kdata:
//  @[info,info,info,info,info],
//             @"result":
//  @[@{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString},
//  @{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString},
//  @{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString},
//  @{kusername:info[kusername],ksignature:info[ksignature],kface_url:info[kface_url],ktime:timeString}]];
}
@end
