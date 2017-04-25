//
//  QYLocationViewController.h
//  骑阅
//
//  Created by chen liang on 2017/4/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^clickBlock)(NSInteger index,NSString *location,CLLocation *loc);
@interface QYLocationViewController : UITableViewController
@property (nonatomic, copy) CLLocation *location;
@property (nonatomic, copy) clickBlock handler;

@end
