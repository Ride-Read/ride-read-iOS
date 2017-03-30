//
//  QYUser.h
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUser : NSObject

@property (nonatomic, strong) NSNumber *sex;        //性别
@property (nonatomic, copy) NSString *location;     //所在地
@property (nonatomic, copy) NSArray *tags;          //标签
@property (nonatomic, copy) NSString *hometown;     //家乡
@property (nonatomic, copy) NSString *face_url;     //头像URL
@property (nonatomic, copy) NSString *phonenumber;  //手机号
@property (nonatomic, copy) NSString *career;       //职业
@property (nonatomic, copy) NSString *school;       //毕业/所在学校
@property (nonatomic, strong) NSNumber *birthday;   //生日
@property (nonatomic, copy) NSString *token;        //token
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, copy) NSString *signature;    //个性签名
@property (nonatomic, strong) NSNumber *created_at;
@property (nonatomic, strong) NSNumber *follower;
@property (nonatomic, strong) NSNumber *following;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSNumber *updated_at;

+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
