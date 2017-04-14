//
//  NSString+QYRegular.h
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QYRegular)

- (NSRange)regularReply:(NSString *)string;

/**
 验证验证码如果正确随机生成一个六位数字

 @param phoneNumber phoneNumber
 @return resutl
 */
- (NSString *)verifyPhoneNumber:(NSString *)phoneNumber;

- (BOOL)checkSpaceText;
- (BOOL)checkPhoneText;
- (BOOL)checkRide_read_id;

@end
