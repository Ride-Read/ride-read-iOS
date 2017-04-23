//
//  QYCustomAnnotionView.h
//  骑阅
//
//  Created by chen liang on 2017/4/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "QYAnnotionModel.h"

@class QYCustomAnnotionView;
@protocol QYCustomAnnotionViewDelegate <NSObject>

@optional;

- (void)clickCustomAnnotion:(QYCustomAnnotionView *)view info:(NSDictionary *)info;

@end
@interface QYCustomAnnotionView : MAAnnotationView
@property (nonatomic, weak) id <QYCustomAnnotionViewDelegate> delegate;

@end
