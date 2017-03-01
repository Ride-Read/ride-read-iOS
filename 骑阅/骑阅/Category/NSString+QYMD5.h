//
//  NSString+QYMD5.h
//  骑阅
//
//  Created by 亮 on 2017/2/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QYMD5)

+(NSString *)getBase64String:(NSString *)string;
+(NSString *)getMD5String:(NSString *)str;
@end
