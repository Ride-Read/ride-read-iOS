//
//  QYPersonalDataViewController.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/7.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTranslucentNoViewController.h"
#import "QYUser.h"
#import "QYBasicNeedLocationController.h"

@interface QYPersonalDataViewController : QYBasicNeedLocationController
@property (nonatomic, weak) QYUser *user;

@end
