//
//  QYRecentlyCycleReform.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRecentlyCycleReform.h"
#import <MAMapKit/MAMapKit.h>
#import "QYPersionMapApiManager.h"
#import "define.h"
#import "QYPersonAnnotion.h"
#import "QYRecentlyCycleApiManager.h"
#import "NSString+QYDateString.h"

@implementation QYRecentlyCycleReform

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    
    if ([manager isKindOfClass:[QYPersionMapApiManager class]]) {
        
        NSArray *reuslt = data[kdata];
        NSMutableArray *perMaps = @[].mutableCopy;
        for (NSDictionary *info in reuslt) {
            
            QYPersonAnnotion *annotion = [[QYPersonAnnotion alloc] init];
            CLLocationCoordinate2D coor;
            NSNumber *latitude = info[klatitude];
            NSNumber *longti = info[klongitude];
            NSString *msg = info[kmsg];
            NSString *cover = info[@"first_picture"];
            if ([cover isKindOfClass:[NSNull class]]) {
                
                cover = @"";
            }
            NSNumber *mid = info[kmid];
            NSNumber *uid = info[kuid];
            NSDictionary *cycle = @{klatitude:latitude,klongitude:longti,kmsg:msg?:@"",kcover:cover?:@"",kmid:mid,kuid:uid};
            coor.latitude = latitude.doubleValue;
            coor.longitude = longti.doubleValue;
            annotion.info = cycle;
            annotion.coordinate = coor;
            [perMaps addObject:annotion];
            
        }
        return perMaps;
    }
    
    if ([manager isKindOfClass:[QYRecentlyCycleApiManager class]]) {
        
        NSArray *reuslt = data[kdata];
        NSMutableArray *cycles = @[].mutableCopy;
        for (NSDictionary *info in reuslt) {
            
            QYPersonAnnotion *annotion = [[QYPersonAnnotion alloc] init];
            CLLocationCoordinate2D coor;
            NSNumber *latitude = info[klatitude];
            NSNumber *longti = info[klongitude];
            NSString *msg = info[kmsg];
            NSString *pics = info[@"pictureString"];
            NSArray *picA;
            NSString *cover;
            if ([pics isKindOfClass:[NSNull class]]) {
                
                picA = @[];
                cover = @"";
            } else {
                picA = [pics componentsSeparatedByString:@","];
                cover = picA[0];
            }
            
            NSNumber *mid = info[kmid];
            NSNumber *uid = info[kuid];
            NSNumber *count = info[kcount];
            NSString *countText;
            if ([count isKindOfClass:[NSNull class]]) {
                
                count = @(0);
                countText = @"0";
            } else {
                
                if (count.integerValue > 100) {
                    
                    countText = @"...";
                } else {
                    
                    countText = [NSString stringWithFormat:@"%@",count];
                }
            }
            NSDictionary *cycle = @{klatitude:latitude,klongitude:longti,kmsg:msg?:@"",kcover:cover?:@"",kmid:mid,kuid:uid,kcount:countText};
            coor.latitude = latitude.doubleValue;
            coor.longitude = longti.doubleValue;
            annotion.info = cycle;
            annotion.coordinate = coor;
            [cycles addObject:annotion];
        }
        
        return cycles;
            
    }

    return nil;
}
@end
