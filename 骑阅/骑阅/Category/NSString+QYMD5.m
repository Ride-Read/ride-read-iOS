//
//  NSString+QYMD5.m
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "NSString+QYMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (QYMD5)

+(NSString *)getBase64String:(NSString *)string {
    
    NSString *result;
    NSData *encodeData = [string dataUsingEncoding:NSUTF8StringEncoding];
    result = [encodeData base64EncodedStringWithOptions:0];
    return result;
}

+(NSString *)getMD5String:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",result[i]];
    }
    return [string copy];
}

@end
