//
//  QYCyclePostController.h
//  骑阅
//
//  Created by chen liang on 2017/3/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYNeedSiteViewController.h"
#import "QYSignAnnotion.h"

typedef void(^sendCycleReuslt)(QYSignAnnotion *anno,NSError *error);
@interface QYCyclePostController : QYBasicNeedLocationController
@property (nonatomic, copy) sendCycleReuslt postResult;
@end
