//
//  QYCity.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/27.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYCity : NSObject
/** city */
@property(nonatomic,copy) NSString * name;
/** areas */
@property(nonatomic,copy) NSArray * areas;
+ (instancetype)loadWithDict:(NSDictionary *)dict;
@end
