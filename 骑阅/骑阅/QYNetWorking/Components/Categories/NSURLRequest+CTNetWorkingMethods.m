//
//  NSURLRequest+CTNetWorkingMethods.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "NSURLRequest+CTNetWorkingMethods.h"
#import <objc/runtime.h>

static void *CTNetWorkingRequestParams;
@implementation NSURLRequest (CTNetWorkingMethods)


-(void)setRequestParams:(NSDictionary *)requestParams {
    
    objc_setAssociatedObject(self, &CTNetWorkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

-(NSDictionary *)requestParams {
    
    return objc_getAssociatedObject(self, &CTNetWorkingRequestParams);
}
@end
