//
//  QYSearchApiManager.m
//  骑阅
//
//  Created by chen liang on 2017/3/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//


#import "QYSearchApiManager.h"
#import "define.h"

@interface QYSearchApiManager ()<CTAPIManagerValidator,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, copy) NSString *text;

@end
@implementation QYSearchApiManager

- (instancetype)init {
    
    self = [super init];
    self.validator = self;
    self.paramSource = self;
    self.delegate = self;
    return self;
}

- (NSString *)methodName {
    
    return @"users/search_follower_or_following";
}

- (NSString *)serviceType {
    
    return kCTServiceAuthonticationYY;
}
- (CTAPIManagerRequestType)requestType {
    
    return CTAPIBaseManagerRequestTypePost;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamData:(NSDictionary *)data {
    
    
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    
    NSNumber *status = data[kstatus];
    if (status.integerValue == 0) {
        
        return YES;
    }
    return NO;
}

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    
    NSNumber *uid = [CTAppContext sharedInstance].currentUser.uid;
    return @{kshortname:self.text?:@"",kuid:uid};
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    
    NSUInteger requestId = manager.response.requestId;
    if ([self.search respondsToSelector:@selector(searchFailed:manager:)]) {
        
        [self.search searchFailed:requestId manager:manager];
    }
}

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    
    NSUInteger requestId = manager.response.requestId;
    if ([self.search respondsToSelector:@selector(searchSuccess:manager:)]) {
        
        [self.search searchSuccess:requestId manager:manager];
    }

}
- (void)searchView:(UIView *)search textDidChange:(NSString *)text {
    
    self.text = text;
    NSUInteger requestId = [self loadData];
    if ([self.search respondsToSelector:@selector(searchStart:manager:)]) {
        
        [self.search searchStart:requestId manager:self];
    }
}

- (void)searchView:(UIView *)search textEndChange:(NSString *)text {
    
    self.text = text;
    NSUInteger requestId = [self loadData];
    if ([self.search respondsToSelector:@selector(searchStart:manager:)]) {
        
        [self.search searchStart:requestId manager:self];
    }
}
@end
