//
//  QYSearchApiManager.h
//  骑阅
//
//  Created by chen liang on 2017/3/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "CTAPIBaseManager.h"
#import "QYViewClickProtocol.h"

@protocol QYSearchActionDelegate <NSObject>

- (void)searchStart:(NSInteger)searchId manager:(CTAPIBaseManager *)manager;
- (void)searchSuccess:(NSInteger)searchId manager:(CTAPIBaseManager *)manager;;
- (void)searchFailed:(NSInteger)searchId manager:(CTAPIBaseManager *)manager;
@end
@interface QYSearchApiManager : CTAPIBaseManager<CTAPIManager,QYSearchViewProtocol>
@property (nonatomic, weak) id <QYSearchActionDelegate> search;

@end
