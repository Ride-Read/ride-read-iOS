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

@interface QYReadLookUserController : QYBasicNeedLocationController
@property (nonatomic, strong) QYUser *user;
@property (nonatomic, strong) QYReadMeHeaderView *headerView;


@end
