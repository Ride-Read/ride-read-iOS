//
//  NSArray+AXNetworkingMethods.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "NSArray+AXNetworkingMethods.h"

@implementation NSArray (AXNetworkingMethods)

-(NSString *)AX_paramsString {
    
    NSMutableString *paramString = [[NSMutableString alloc] init];
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    
    [sortedParams enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([paramString length] == 0) {
            
            [paramString appendFormat:@"%@",obj];
        } else {
            
            [paramString appendFormat:@"&%@",obj];
        }
        
    }];
    
    return paramString;
}

-(NSString *)AX_jsonString {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
