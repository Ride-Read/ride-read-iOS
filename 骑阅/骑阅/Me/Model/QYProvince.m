//
//  QYAddress.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/27.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYProvince.h"

@implementation QYProvince

+(instancetype)loadWithDict:(NSDictionary *)dict {
    
    QYProvince * province = [[QYProvince alloc]init];
    province.name = dict[@"state"];
    province.cities = dict[@"cities"];
    return province;
}
@end
