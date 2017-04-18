//
//  QYMomentReform.m
//  骑阅
//
//  Created by chen liang on 2017/4/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYMomentReform.h"
#import "define.h"
#import "NSString+QYDateString.h"

@implementation QYMomentReform


- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    NSDictionary *dic = data[kdata];
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
    NSString *leght = dic[@"distance_string"];
    leght = [NSString stringWithFormat:@"距离我%@",leght];
    NSNumber *atte = dic[@"user"][@"is_followed"];
    NSString *attName;
    NSNumber *attTag;
    NSMutableArray *commResutl = [NSMutableArray array];
    for (NSDictionary *com in comment ) {
        
        NSNumber *reply_id = com[@"reply_uid"];
        if (reply_id && ![reply_id isKindOfClass:[NSNull class]]) {
            
            NSMutableDictionary *comm = [NSMutableDictionary dictionaryWithDictionary:com];
            comm[kmsg] = [NSString stringWithFormat:@"回复 %@:%@",comm[@"reply_username"]?:@"",comm[kmsg]];
            comm[kreply] = @{kuid:comm[@"reply_uid"],kusername:comm[@"reply_username"]?:@" "};
            [commResutl addObject:comm];
            
        } else
        {
            [commResutl addObject:com];
        }
        
    }
    
    if ([atte isKindOfClass:[NSNull class]]) {
        
        atte = @(-1);
    }
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
    attName = @"";
    attTag = @(-1);
    NSString *site = dic[kmoment_location];
    NSMutableDictionary *cycle = @{@"tag":attTag,kface_url:avater?:@"",kusername:name?:@"",kuid:uid,kmid:mid,kmsg:msg?:@"",kthumbs:picA,kcreated_at:timeS,kcomment:commResutl?:@[],kpraise:thumbs_up?:@[],ksiteLength:leght?:@"",kstatus:attName,ksite:site?:@""}.mutableCopy;
    
    return cycle;
}
@end
