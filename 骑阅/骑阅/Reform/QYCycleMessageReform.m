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
        NSString *name = dic[@"user"][kusername];
        NSString *avater = dic[@"user"][kface_url];
        NSString *pics = dic[@"pictureString"];
        NSArray *picA;
        if ([pics isKindOfClass:[NSNull class]]) {
            
            picA = @[];
        } else
            picA = [pics componentsSeparatedByString:@","];
        
        NSNumber *time = dic[kcreated_at];
        NSString *timeS = [NSString dateStringWithTime:time.doubleValue];
        NSArray *comment = dic[kcomment];
        NSArray *thumbs_up = dic[@"thumbs_up"];
        NSString *leght = dic[@"distanceString"];
        NSNumber *atte = dic[@"user"][@"is_followed"];
        NSString *attName;
        NSNumber *attTag;
        if (atte.integerValue == 1 || atte.integerValue == 0) {
            
            attName = @"attentioned";
            attTag = @(1);
        }
        
        if (atte.integerValue == -1) {
            
            attName = @"attention";
            attTag = @(0);
            NSNumber *cuui = [CTAppContext sharedInstance].currentUser.uid;
            if (cuui.integerValue == uid.integerValue) {
                
                attName = @"";
                attTag = @(-1);
            }
        }
        NSDictionary *cycle = @{@"tag":attTag,kface_url:avater?:@"",kusername:name?:@"",ksite:@"广州",kuid:uid,kmid:mid,kmsg:msg?:@"",kthumbs:picA,kcreated_at:timeS,kcomment:comment?:@[],kpraise:thumbs_up?:@[],ksiteLength:leght,kstatus:attName};
        [cycleInfos addObject:[cycle mutableCopy]];
        
    }
    return cycleInfos;
    
}

@end
