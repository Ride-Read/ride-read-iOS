//
//  CLBasicIterator.h
//  demo-k-means
//
//  Created by liang on 2017/4/27.
//  Copyright © 2017年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "QYPersonAnnotion.h"

@interface CLBasicIterator : NSObject
@property (nonatomic, strong) NSArray <id <QYLocationDelegate> > *array;

- (void)loadDataByScale:(float)scale result:(void(^)(NSArray *array))result;
@end
