//
//  QYAnnotationView.h
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "QYLocationAnnotionView.h"

@interface QYAnnotationView : MAAnnotationView
@property (nonatomic, strong) QYLocationAnnotionView *locaView;
+ (instancetype)annotionViewMapView:(MAMapView *)mapView;
@end
