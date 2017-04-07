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
#import "define.h"

@implementation QYUserReform

- (id)logic:(CLAppLogic *)logic withTheManager:(CTAPIBaseManager *)manager reformData:(id)data {
    
    return data;
}

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    
    if ([manager isKindOfClass:[QYAddThumbApiManager class]]) {
        
        return nil;
    }
    
    if ([manager isKindOfClass:[QYAddCommnetApiManager class]]) {
        
        
        return data[@"data"];
    }
    return nil;
}
@end
