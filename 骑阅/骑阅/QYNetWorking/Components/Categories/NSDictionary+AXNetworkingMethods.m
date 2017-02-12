//
//  NSDictionary+AXNetworkingMethods.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "NSDictionary+AXNetworkingMethods.h"
#import "NSArray+AXNetworkingMethods.h"

@implementation NSDictionary (AXNetworkingMethods)

-(NSString *)CT_urlParamsStringSignature:(BOOL)isForSignature {
    
    NSArray *sortedArray = [self CT_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray AX_paramsString];
    
    
}

-(NSString *)CT_jsonString {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(NSArray *)CT_transformedUrlParamsArraySignature:(BOOL)isForSignature {
    
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if (![obj isKindOfClass:[NSString class]]) {
            
            obj = [NSString stringWithFormat:@"%@",obj];
        }
        
        if (!isForSignature) {
            
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)obj, NULL,(CFStringRef)@"!*'();:@&;=+$,/?%#[]",kCFStringEncodingUTF8));
        }
        
        if ([obj length] > 0) {
            
            [result addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }
        
    }];
    
    NSArray *sortedReuslt = [result sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedReuslt;
}

@end
