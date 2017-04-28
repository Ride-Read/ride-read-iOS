//
//  QYSelecteLocationViewController.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"

@class QYSelecteLocationViewController;

@protocol QYSelectedLoactionDelegate <NSObject>

- (void)viewController:(QYSelecteLocationViewController *)controller didFinishedSelectedAddress:(NSString *)address;

@end

@interface QYSelecteLocationViewController : QYBasicViewController

/** delegate */
@property(nonatomic,weak) id<QYSelectedLoactionDelegate> delegate;
/** type */
@property(nonatomic,assign) NSInteger type;
@end
