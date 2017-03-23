//
//  QYCycleCollectApiManager.h
//  骑阅
//
//  Created by chen liang on 2017/3/24.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "CTAPIBaseManager.h"

@interface QYCycleCollectApiManager : CTAPIBaseManager<CTAPIManager>

@property (nonatomic, assign) BOOL isRefesh;
@property (nonatomic, assign) BOOL isLoadMore;

-(void)loadNext;
-(void)loadLaste;

@end
