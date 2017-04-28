//
//  QYAddress.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/27.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYProvince : NSObject
/** provinceName */
@property(nonatomic,copy) NSString * name;
/** cities */
@property(nonatomic,copy) NSArray * cities;
+(instancetype)loadWithDict:(NSDictionary *)dict;
@end
