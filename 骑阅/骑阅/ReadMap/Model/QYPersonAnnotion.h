//
//  QYPersonAnnotion.h
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAnnotionModel.h"

@protocol QYLocationDelegate <NSObject>

- (CLLocation *)locationForAnnotion;

@end

@interface QYPersonAnnotion : QYAnnotionModel<QYLocationDelegate>

@end
