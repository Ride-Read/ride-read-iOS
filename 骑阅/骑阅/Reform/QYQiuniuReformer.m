//
//  QYQiuniuReformer.m
//  骑阅
//
//  Created by chen liang on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYQiuniuReformer.h"
#import "define.h"

@implementation QYQiuniuReformer

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    NSString *token = data[@"qiniu_token"];
    return token;
}
@end
