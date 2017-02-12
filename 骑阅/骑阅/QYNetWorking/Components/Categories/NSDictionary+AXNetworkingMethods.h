//
//  NSDictionary+AXNetworkingMethods.h
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AXNetworkingMethods)

-(NSString *)CT_urlParamsStringSignature:(BOOL)isForSignature;
-(NSString *)CT_jsonString;
-(NSArray *)CT_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
