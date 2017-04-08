//
//  QYAttentOrFansViewController.h
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTranslucentNoViewController.h"
#import "YYBasicTableView.h"
#import "QYAttentionOrFansApiManager.h"

@interface QYAttentOrFansViewController : QYTranslucentNoViewController<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *userArrays;
@property (nonatomic, strong) QYAttentionOrFansApiManager *userApiManager;


- (NSDictionary *)paramForUserApi;
@end
