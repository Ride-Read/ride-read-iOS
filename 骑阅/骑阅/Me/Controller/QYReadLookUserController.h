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


@interface QYReadLookUserController : QYBasicNeedLocationController
@property (nonatomic, strong) NSMutableDictionary *user;
@property (nonatomic, strong) QYReadMeHeaderView *headerView;
@property (nonatomic, strong) QYAttentionAndMessageView *attentionAndMessageView;
@property (nonatomic, strong) YYBasicTableView *tableView;


- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager;
- (void)setContentView;
@end
