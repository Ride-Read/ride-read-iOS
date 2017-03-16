//
//  QYQiuniuTokenCommand.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYQiuniuTokenCommand.h"
#import "QYGetQiNiuTokenApiManager.h"
#import "QYQiuniuReformer.h"
#import "QYQiuniuUploadCommand.h"

@interface QYQiuniuTokenCommand ()
@property (nonatomic, strong) QYQiuniuReformer *reformer;
@property (nonatomic, strong) QYQiuniuUploadCommand *up;

@end
@implementation QYQiuniuTokenCommand
@synthesize apiManager;
@synthesize next;

- (NSDictionary *)paramsFormNextCommand:(CTAPIBaseManager *)curentManager {
    
   NSString *token = [self.apiManager fetchDataWithReformer:self.reformer];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.nextParams];
    [dict setObject:token forKey:@"token"];
    return dict;
}
- (CTAPIBaseManager *)apiManager {
    
    if (!apiManager) {
        apiManager = [[QYGetQiNiuTokenApiManager alloc] init];
        apiManager.delegate = self;
        apiManager.paramSource = self;
    }
    return apiManager;
}

- (QYQiuniuReformer *)reformer {
    
    if (!_reformer) {
        
        _reformer = [[QYQiuniuReformer alloc] init];
    }
    return _reformer;
}
- (CLCommands *)next {
    
    if (!_up) {
        
        _up = [[QYQiuniuUploadCommand alloc] init];
        _up.complete = self.complete;
    }
    return _up;
}

@end
