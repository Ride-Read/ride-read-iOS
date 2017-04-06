//
//  QYCycleMessageReform.m
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleMessageReform.h"
#import "define.h"
#import "NSString+QYDateString.h"

@implementation QYCycleMessageReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    NSArray *cycles = data[kdata];
    NSMutableArray *cycleInfos = @[].mutableCopy;
    for (NSDictionary *dic in cycles) {
        
        NSNumber *uid = dic[kuid];
        NSNumber *mid = dic[kmid];
        NSString *msg = dic[kmsg];
        NSString *pics = dic[@"pictureString"];
        NSArray *picA = [pics componentsSeparatedByString:@","];
        NSNumber *time = dic[kcreated_at];
        NSString *timeS = [NSString dateStringWithTime:time.doubleValue];
        NSArray *comment = data[kcomment];
        NSArray *thumbs_up = data[@"thumbs_up"];
        NSString *leght = data[@"distanceString"];
        NSDictionary *cycle = @{ksite:@"广州",kuid:uid,kmid:mid,kmsg:msg?:@"",kthumbs:picA,ktime:timeS,kcomment:comment,kpraise:thumbs_up,ksiteLength:leght};
        [cycleInfos addObject:cycle];
        
    }
    return cycleInfos;
    
}

@end
