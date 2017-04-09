//
//  QYBasicViewController.h
//  骑阅
//
//  Created by chen liang on 2017/2/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTLocationManager.h"
#import "QYDataRefreshProtocol.h"
/**
 BasicController do nothting
 Suggest all controller inherit this
 */
@interface QYBasicViewController : UIViewController<QYDataRefreshProtocol>
@property (nonatomic, strong) NSOperationQueue *serialQueue;
@property (nonatomic, copy) CLLocation *location;
@property (nonatomic, weak) id <QYDataRefreshProtocol> dataRefresh;

@end
