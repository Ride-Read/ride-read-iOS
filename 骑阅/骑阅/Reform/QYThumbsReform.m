//
//  QYThumbsReform.m
//  骑阅
//
//  Created by chen liang on 2017/4/17.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYThumbsReform.h"
#import "define.h"

@implementation QYThumbsReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
 
    NSArray *users = data[kdata];
    NSMutableArray *result = @[].mutableCopy;
    for (NSDictionary *info in users) {
            
        NSNumber *fid = info[kuid];
        NSString *username = info[@"username"];
        NSString *sigature = info[@"signature"];
        if ([sigature isKindOfClass:[NSNull class]]) {
                
            sigature = @"";
        }
        NSString *avater = info[@"face_url"];
        NSString *timeText = @"";
        NSNumber *is_followed = info[@"is_followed"];
        NSString *stauts = @"attention";
        NSNumber *tag = @(0);
        if (is_followed.integerValue==0||is_followed.integerValue == 1) {
            
            stauts = @"attentioned";
            tag = @(1);
        }
        
        NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
        if (uid.integerValue == fid.integerValue) {
            
            stauts = @"";
            tag = @(3);
        }
        NSMutableDictionary *user = @{kstatus:stauts,@"tag":tag,
                                      kuid:fid,kusername:username?:@"",
                                      ksignature:sigature?:@"",kface_url:avater?:@"",
                                      ktime:timeText}.mutableCopy;
        [result addObject:user];
    }
        
        return result;
}
@end
