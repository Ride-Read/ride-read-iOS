//
//  QYCycleCollectReform.m
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleCollectReform.h"
#import "define.h"
#import "NSString+QYDateString.h"

@implementation QYCycleCollectReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-10000];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    NSString *time = [NSString dateStringWithTime:interval];
    return @[@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time},@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time},@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time},@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time},@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time},@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time},@{kcover:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kface_url:@"http://pic8.qiyipic.com/image/20160728/ed/a7/a_100013977_m_601_m5_195_260.jpg",kusername:@"snow",kmsg:@"这里很好看",kfrom:@"附近",ktime:time}];
}
@end
