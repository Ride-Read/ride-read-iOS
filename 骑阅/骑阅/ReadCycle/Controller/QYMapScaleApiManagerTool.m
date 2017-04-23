//
//  QYMapScaleApiManagerTool.m
//  骑阅
//
//  Created by chen liang on 2017/4/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYMapScaleApiManagerTool.h"
#import "QYRecentlyCycleApiManager.h"

@implementation QYMapScaleApiManagerTool
@synthesize apiManager;

- (CTAPIBaseManager *)apiManager {
    
    if (!apiManager) {
        
        apiManager = [[QYRecentlyCycleApiManager alloc] init];
        apiManager.delegate = self;
        apiManager.paramSource = self;
    }
    return apiManager;
}
@end
