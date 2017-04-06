//
//  QYBasicNeedLocationController.h
//  骑阅
//
//  Created by chen liang on 2017/4/3.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"
#import "CTLocationManager.h"

@interface QYBasicNeedLocationController : QYBasicViewController

//for sublcass call
- (void)locationServiceError:(NSNotification *)info;
- (void)locationResult:(NSNotification *)info;
@end
