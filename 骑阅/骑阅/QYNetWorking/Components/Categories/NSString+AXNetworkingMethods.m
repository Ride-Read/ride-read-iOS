//
//  NSString+AXNetworkingMethods.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "NSString+AXNetworkingMethods.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSObject+AXNetworkingMethods.h"

@implementation NSString (AXNetworkingMethods)

-(NSString *)AX_md5 {
    
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes],(unsigned int)[inputData length],outputData);
    NSMutableString *hasStr = [NSMutableString string];
    int i = 0;
    for ( i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [hasStr appendFormat:@"%02x",outputData[i]];
    }
    
         return hasStr;
}

@end
