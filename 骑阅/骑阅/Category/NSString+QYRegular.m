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
    
    NSString *pattern = [NSString stringWithFormat:@"回复 ([.\\s\\S]+):"];
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *array = [regular matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    NSRange result = NSMakeRange(0, 0);
    if (array.count > 0) {
        NSTextCheckingResult *check = array[0];
        result = [check rangeAtIndex:1];
    }
    return result;
}

- (NSString *)verifyPhoneNumber:(NSString *)phoneNumber {
    
    NSString *regex = @"^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL correct = [test evaluateWithObject:self];
    if (correct) {
        
        NSString *strRandom = @"";
        
        for(int i=0; i< 6; i++)
        {
            strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
        }
        return strRandom;
        
    } else {
        return nil;
    }
}

- (BOOL)checkSpaceText {
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([self stringByTrimmingCharactersInSet:set].length == 0) {
        
        return YES;
    }
    
    return NO;
}

@end
