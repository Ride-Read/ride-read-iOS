//
//  QYAttentOrFansViewController.h
//  骑阅
//
//  Created by chen liang on 2017/3/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTranslucentNoViewController.h"
#import "YYBasicTableView.h"

@interface QYAttentOrFansViewController : QYTranslucentNoViewController
@property (nonatomic, strong) YYBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *userArrays;

- (NSDictionary *)paramForUserApi;
@end
