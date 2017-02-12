//
//  NSMutableString+AXNetworkingMethods.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "NSMutableString+AXNetworkingMethods.h"
#import "NSObject+AXNetworkingMethods.h"

@implementation NSMutableString (AXNetworkingMethods)

-(void)appendURLRequest:(NSURLRequest *)request {
    
    [self appendFormat:@"\n\nHTTP URL:\n\t%@",request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@",request.allHTTPHeaderFields?request.allHTTPHeaderFields:@"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@",[[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] CT_defaultValue:@"\t\t\t\tN/A"]];
}

@end
