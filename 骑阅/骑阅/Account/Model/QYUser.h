//
//  QYUser.h
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUser : NSObject

@property (nonatomic, strong) NSNumber *sex;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *hometowm;
@property (nonatomic, copy) NSString *face_url;
@property (nonatomic, copy) NSString *phonenumber;
@property (nonatomic, copy) NSString *career;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, strong) NSNumber *birthday;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, copy) NSString *sigature;
@property (nonatomic, strong) NSNumber *create_at;
@property (nonatomic, strong) NSNumber *follower;
@property (nonatomic, strong) NSNumber *following;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) NSNumber *updated_at;

+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
