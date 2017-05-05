//
//  CLBasicIterator.m
//  demo-k-means
//
//  Created by liang on 2017/4/27.
//  Copyright © 2017年 liang. All rights reserved.
//

#import "CLBasicIterator.h"

@interface CLBasicIterator ()
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, assign) NSInteger categoryNumber;
@property (nonatomic, assign) NSInteger maxiterator;
@property (nonatomic, strong) NSOperationQueue *calculateQueue;
@property (nonatomic, strong) NSOperationQueue *mainQueue;
@property (nonatomic, assign) NSInteger preScale;
@property (nonatomic, assign) NSInteger curScale;
@property (nonatomic, strong) NSDictionary *scaleMap;

@end
@implementation CLBasicIterator

- (instancetype)init {
    
    self = [super init];
    return self;
}

#pragma mark - getter and setter

- (NSCache *)cache {
    
    if (!_cache) {
        
        _cache = [[NSCache alloc] init];
    }
    return _cache;
}

- (NSOperationQueue *)calculateQueue {
    
    if (!_calculateQueue) {
        
        _calculateQueue = [[NSOperationQueue alloc] init];
        _calculateQueue.maxConcurrentOperationCount = 9;
    }
    return _calculateQueue;
}

- (NSOperationQueue *)mainQueue {
    
    if (!_mainQueue) {
        
        _mainQueue = [NSOperationQueue mainQueue];
    }
    return _mainQueue;
}
- (NSDictionary *)scaleMap {
    
    if (!_scaleMap) {
        
        _scaleMap = @{@20: @10,
            @19: @20,
            @18: @50,
            @17: @100,
            @16: @200,
            @15: @500,
            @14: @1000,
            @13: @2000,
            @12: @5000,
            @11: @10000,
            @10: @20000,
            @9: @25000,
            @8: @50000,
            @7: @100000,
            @6: @200000,
            @5: @500000,
            @4: @1000000,
            @3: @2000000}
;
    }
    return _scaleMap;
}

- (void)setArray:(NSArray *)array {
    
    _array = array;
    [self sortCategoryByData];
}
#pragma mark - publice method
- (void)loadDataByScale:(float)scale result:(void (^)(NSArray *))result {
    
    NSInteger zoomScale = scale;
    self.curScale = zoomScale;
    NSArray *array = [self.cache objectForKey:@(zoomScale)];
    if (array) {
        
        result(array);
    } else {
        
        [self analyzeData:zoomScale result:result];
    }
    
}

#pragma mark - pirvate method
- (void)analyzeData:(NSInteger)scale result:(void(^)(NSArray *))result {
    
    [self.calculateQueue addOperationWithBlock:^{
       
        NSArray *data = [self.cache objectForKey:@(scale)];
        if (data) {
            
            [self.mainQueue addOperationWithBlock:^{
               
                result(data);
            }];
        }
        
        NSInteger zoom = scale;
        NSMutableArray *cateArray = @[].mutableCopy;
        for (int i = 0; i < self.categoryNumber; i++) {
            
            [cateArray addObject:[self gategoryDataByNumber:i]];
        }
        NSNumber *length = self.scaleMap[@(scale)];
        [self iteratorData:cateArray limit:2000 length:length.intValue result:^(NSArray *array) {
        
            [self.cache setObject:array forKey:@(zoom)];
            [self.mainQueue addOperationWithBlock:^{
                
                result(array);
            }];
        }];
      
    }];
}

-(void)iteratorData:(NSArray *)array limit:(int)limit length:(int)length result:(void(^)(NSArray *))result {
    
    NSMutableArray *tempArray = @[].mutableCopy;
   
    for (int i = 0; i < array.count; i ++) {
        
        [tempArray addObject:@[].mutableCopy];
    }
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        QYPersonAnnotion *anno = obj;
        CLLocation *location = [anno locationForAnnotion];
        for (int i = 0; i < array.count; i++) {
            
            NSMutableArray *info = array[i];
            CLLocation *loc = [self calculateCenterlegth:info];
            
            double distance = [self calculateTwoPointLength:location to:loc];
            if (distance < length) {
                NSMutableArray *newInfo = tempArray[i];
                [newInfo addObject:obj];
                break;
            }
  
        }
      
    }];
#ifdef DEBUG
    NSLog(@"cureent iterator count:%d on this length:%d",2000 - limit,length);
#endif
   BOOL restrain = [self checkRestrainData:tempArray length:length];
    if (restrain || limit == 0) {
        if (limit == 0) {
            
#ifdef DEBUG
            
            NSLog(@"have more than the max iterator count");
#endif
        } else {
            
#ifdef DEBUG
            
            NSLog(@"data have restrain iterator can end with iterator count:%d",2000-limit);
#endif
        }
#ifdef DEBUG
        NSLog(@"check callback count");
#endif
        
        NSMutableArray *endResult = @[].mutableCopy;
        [self.array enumerateObjectsUsingBlock:^(id<QYLocationDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            QYPersonAnnotion *annotion = (QYPersonAnnotion *)obj;
            __block BOOL find = NO;
            [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull level_stop) {
                
                NSArray *categoryArray = obj;
                [categoryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    QYPersonAnnotion *anno = obj;
                    if (anno == annotion) {
                        
                        *stop = YES;
                        *level_stop = YES;
                        find = YES;
                    }
                }];
            }];
            
            if (!find) {
                
                [endResult addObject:@[annotion]];
            }
        }];
        [endResult addObjectsFromArray:tempArray];
        result(endResult);
        return;
    }
    NSMutableArray *reArray = [NSMutableArray arrayWithArray:tempArray];
    [self iteratorData:reArray limit:--limit length:length result:result];
    
    
}

- (BOOL)checkRestrainData:(NSArray<id<QYLocationDelegate>> *)array length:(int)length {
    
   __block BOOL restrain = YES;
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSArray *info = obj;
        CLLocation *loc = [self calculateCenterlegth:info];
        for (id<QYLocationDelegate> location in info) {
            
            double distance = [self calculateTwoPointLength:[location locationForAnnotion] to:loc];
            if (distance > length) {
                
                restrain = NO;
                *stop = YES;
                break;
            }
        }
        
    }];
    return restrain;
}

- (void)sortCategoryByData {
    
    NSInteger k;
    if (self.array.count < 9) {
        
        k = self.array.count;
    } else
    {
        k = 9;
    }

    self.categoryNumber = k;
}

- (NSMutableArray *)gategoryDataByNumber:(NSInteger)number {
    
    NSInteger count = self.array.count/self.categoryNumber;
    NSArray *array;
    if (number == self.array.count - 1) {
        
        array = [self.array subarrayWithRange:NSMakeRange((self.categoryNumber-1) * count, self.array.count -(self.categoryNumber-1) * count)];
        
    } else {
        
        array = [self.array subarrayWithRange:NSMakeRange(number * count, count)];
    }
    return array.mutableCopy;
}

- (CLLocation *)calculateCenterlegth:(NSArray<id<QYLocationDelegate>> *)data {
    
    CLLocation *location;
    double latiSum = 0;
    double lontiSum = 0;
    for (id <QYLocationDelegate> loc in data) {
        
        CLLocation *location = [loc locationForAnnotion];
        latiSum = latiSum + location.coordinate.latitude;
        lontiSum = lontiSum + location.coordinate.longitude;
    }
    double lati = latiSum/data.count;
    double lonti = lontiSum/data.count;
    location = [[CLLocation alloc] initWithLatitude:lati longitude:lonti];
    return location;
    
}

- (double)calculateTwoPointLength:(CLLocation *)from to:(CLLocation *)to {
    
    CLLocationDistance distance = [from distanceFromLocation:to];
    return distance;
}


@end
