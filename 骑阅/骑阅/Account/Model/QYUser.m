//
//  QYUser.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUser.h"
#import "define.h"

@implementation QYUser

+ (instancetype)userWithDict:(NSDictionary *)dict {
    
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    [super setValue:value forUndefinedKey:key];
    MyLog(@"%@",key);
}


@end
