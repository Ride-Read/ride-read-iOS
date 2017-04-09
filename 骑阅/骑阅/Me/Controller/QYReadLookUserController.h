//
//  QYReadLookUserController.h
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicNeedLocationController.h"
#import "QYUser.h"
#import "QYReadMeHeaderView.h"
#import "CTAPIBaseManager.h"
#import "QYAttentionAndMessageView.h"
#import "YYBasicTableView.h"
#import "QYShowUserCycleApiManager.h"
#import "QYRideUserApiManager.h"
#import "QYUserReform.h"
#import "define.h"

@interface QYReadLookUserController : QYBasicNeedLocationController
@property (nonatomic, strong) NSMutableDictionary *user;
@property (nonatomic, strong) QYReadMeHeaderView *headerView;
@property (nonatomic, strong) QYShowUserCycleApiManager *cycleApiManager;
@property (nonatomic, strong) QYAttentionAndMessageView *attentionAndMessageView;
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) QYRideUserApiManager *userApi;
@property (nonatomic, strong) QYUserReform *userReform;


- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager;
- (void)setContentView;
- (void)loadData;
@end
