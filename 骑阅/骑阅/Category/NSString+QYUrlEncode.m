//
//  NSString+QYUrlEncode.m
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "NSString+QYUrlEncode.h"

@implementation NSString (QYUrlEncode)
+ (NSString *)encodeString:(NSString *)string {
    
    NSString *encode =    [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    return encode;
}
@end
