//
//  QYCity.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/27.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCity.h"

@implementation QYCity
+ (instancetype)loadWithDict:(NSDictionary *)dict {
    QYCity * city = [[QYCity alloc]init];
    
    
    city.name = dict[@"city"];
    city.areas = dict[@"cities"];
    return city;
}
@end
