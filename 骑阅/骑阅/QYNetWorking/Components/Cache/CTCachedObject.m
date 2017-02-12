//
//  CTCachedObject.m
//  CLNetWorking
//
//  Created by 亮 on 16/9/12.
//  Copyright © 2016年 亮. All rights reserved.
//

#import "CTCachedObject.h"
#import "CTNetworkingConfiguration.h"

@interface CTCachedObject ()

@property (nonatomic, copy, readwrite) NSData *content;
@property (nonatomic, copy, readwrite) NSDate *lastUpdateTime;

@end

@implementation CTCachedObject

#pragma mark -getters and setters
-(BOOL)isEmty {
    
    return self.content == nil;
}

-(BOOL)isOutdated {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > kCTCacheOutdateTimeSeconds;
}

-(void)setContent:(NSData *)content {
    
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark -life cycle
-(instancetype)initWithContent:(NSData *)content {
    
    self = [super init];
    if (self) {
        
        self.content = content;
    }
    return self;
}

#pragma mark -public method

-(void)updateContent:(NSData *)content {
    
    self.content = content;
}


@end
