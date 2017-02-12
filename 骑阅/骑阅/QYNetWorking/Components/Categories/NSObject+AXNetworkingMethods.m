//
//  NSObject+AXNetworkingMethods.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "NSObject+AXNetworkingMethods.h"

@implementation NSObject (AXNetworkingMethods)

-(id)CT_defaultValue:(id)defaultData {
    
    if (![defaultData isKindOfClass:[self class]]) {
        
        return defaultData;
    }
    if ([self CT_isEmptyObject]) {
        
        return defaultData;
    }
    
    return self;
}

-(BOOL)CT_isEmptyObject {
    
    if ([self isEqual:[NSNull null]]) {
        
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        
        if ([(NSString *)self length] == 0) {
            
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        
        if ([(NSArray *)self count] == 0) {
            
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        
        if ([(NSDictionary *)self count] == 0) {
            
            return YES;
        }
    }
    
    return NO;
}

@end
