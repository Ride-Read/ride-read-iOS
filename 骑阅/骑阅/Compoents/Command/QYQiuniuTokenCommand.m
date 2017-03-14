//
//  QYQiuniuTokenCommand.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYQiuniuTokenCommand.h"
#import "QYGetQiNiuTokenApiManager.h"

@implementation QYQiuniuTokenCommand
@synthesize apiManager;

- (CTAPIBaseManager *)apiManager {
    
    if (apiManager) {
        apiManager = [[QYGetQiNiuTokenApiManager alloc] init];
        apiManager.delegate = self;
        apiManager.paramSource = self;
    }
    return apiManager;
}
@end
