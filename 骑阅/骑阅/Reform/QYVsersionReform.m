//
//  QYVsersionReform.m
//  骑阅
//
//  Created by chen liang on 2017/4/29.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYVsersionReform.h"
#import "define.h"

@implementation QYVsersionReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    BOOL update = NO;
    NSDictionary *version = data[kdata];
    if (![version isKindOfClass:[NSNull class]]) {
        
        NSString *serviceVersion = version[kversion];
        NSString *cuVersion = [CTAppContext sharedInstance].version;
        if ([cuVersion isEqualToString:serviceVersion]) {
            
            update = YES;
        }
        return @{@"update":@(update),klink:version[klink]};
    }
    return @{@"update":@(update),klink:@""};
}

@end
