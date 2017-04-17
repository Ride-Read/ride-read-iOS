//
//  QYAnnotionModel.h
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface QYAnnotionModel : NSObject<MAAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSDictionary *info;

@end
