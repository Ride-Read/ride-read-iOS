//
//  NSString+QYDateString.m
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "NSString+QYDateString.h"

@implementation NSString (QYDateString)

+ (NSString *)dateStringWithTime:(double)date {
    
    date = date / 1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSDate *now = [NSDate new];
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"yyyy-MM-dd"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [NSDateFormatter new];
        [formatterFullDate setDateFormat:@"yyyy-MM-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
        
    });
    
    NSTimeInterval delta = now.timeIntervalSince1970 - createDate.timeIntervalSince1970;
    if (delta < -60 * 10) {
        return [formatterFullDate stringFromDate:createDate];
    } else if (delta < 60 * 1) {
        return @"刚刚";
    } else if (delta < 60 * 60) {
        return [NSString stringWithFormat:@"%d分钟前",(int)(delta / 60.0)];
    } else if (delta < 60 * 24 * 60) {
        return [NSString stringWithFormat:@"%d小时前",(int)(delta / 60.0/60.0)];
    } else {
        return [formatterFullDate stringFromDate:createDate];
    }
}
+ (NSString *)uploadFilename {
    
    static NSDateFormatter *formatter ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddhhmmss"];
    });
    NSDate *date = [NSDate date];
    NSString *filename = [formatter stringFromDate:date];
    filename = [filename stringByAppendingString:@".jpg"];
    filename = [@"icon_" stringByAppendingString:filename];
    return filename;
}

+ (NSString *)dataFormatteryyyymmdd:(NSDate *)date {
    
    NSString *resutl;
    static NSDateFormatter *formatterFullDate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterFullDate = [NSDateFormatter new];
        [formatterFullDate setDateFormat:@"yyyy-MM-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
        
    });
    resutl = [formatterFullDate stringFromDate:date];
    return resutl;
}

@end
