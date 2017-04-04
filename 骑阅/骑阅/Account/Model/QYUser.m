//
//  QYUser.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYUser.h"
#import "define.h"


@implementation QYUser
@synthesize userId = _userId;
@synthesize name = _name;
@synthesize avatarURL = _avatarURL;
@synthesize clientId = _clientId;

+ (instancetype)userWithUserId:(NSString *)userId name:(NSString *)name avatarURL:(NSURL *)avatarURL clientId:(NSString *)clientId {
    
    return [[self alloc] initWithUserId:userId name:name avatarURL:avatarURL clientId:clientId];
}
- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)name avatarURL:(NSURL *)avatarURL clientId:(NSString *)clientId {
    
    self = [super init];
    
    _userId = userId;
    _name = name;
    _avatarURL = avatarURL;
    _clientId = clientId;
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict {
    
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
   // [super setValue:value forUndefinedKey:key];
    MyLog(@"%@",key);
}

- (BOOL)isEqualToUer:(QYUser *)user {
    return (user.userId == self.userId);
}

- (id)copyWithZone:(NSZone *)zone {
    return [[QYUser alloc] initWithUserId:self.userId
                                       name:self.name
                                  avatarURL:self.avatarURL
                                   clientId:self.clientId
            ];
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.avatarURL forKey:@"avatarURL"];
    [aCoder encodeObject:self.clientId forKey:@"clientId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]){
        _userId = [aDecoder decodeObjectForKey:@"userId"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _avatarURL = [aDecoder decodeObjectForKey:@"avatarURL"];
        _clientId = [aDecoder decodeObjectForKey:@"clientId"];
    }
    return self;
}

#pragma mark - getter
- (NSString *)userId {
    
    if (self.uid) {
        
        return [NSString stringWithFormat:@"%@",self.uid];
    }
    return nil;
}

- (NSString *)clientId {
    
    if (self.uid) {
        
        return [NSString stringWithFormat:@"%@",self.uid];
    }

    return nil;
}

- (NSURL *)avatarURL {
    
    if (self.face_url) {
        
        return [NSURL URLWithString:self.face_url];
    }
    return nil;
}

- (NSString *)name {
    
    if (self.username) {
        
        return self.username;
    }
    return nil;
}
@end
