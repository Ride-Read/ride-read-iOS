//
//  QYScaleApiManagerTool.h
//  骑阅
//
//  Created by chen liang on 2017/4/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTAPIBaseManager.h"
#import <CoreLocation/CoreLocation.h>

@interface QYScaleApiManagerTool : NSObject<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) CTAPIBaseManager *apiManager;

- (void)dataWithScale:(CGFloat)scale location:(CLLocation *)location block:(void(^)(NSArray *array,NSError *error))block;
@end
