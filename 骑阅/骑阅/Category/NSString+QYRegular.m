//
//  NSString+QYRegular.m
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "NSString+QYRegular.h"

@implementation NSString (QYRegular)

- (NSRange)regularReply:(NSString *)string {
    
    NSString *pattern = [NSString stringWithFormat:@" 回复([.\\s\\S]+):"];
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *array = [regular matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    NSRange result;
    if (array.count > 0) {
        NSTextCheckingResult *check = array[0];
        result = [check rangeAtIndex:1];
    }
    return result;
}
@end
