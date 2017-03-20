//
//  QYCycleBasicLayout.m
//  骑阅
//
//  Created by chen liang on 2017/3/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleBasicLayout.h"

@implementation QYCycleBasicLayout

+ (instancetype)friendStatusCellLayout:(NSDictionary *)status {
    
    return [[self alloc] initWithStatus:status];
}
- (instancetype)initWithStatus:(NSDictionary *)status {
    
    self = [super init];
    self.status = status;
    self.marginTop = kQYCellTopMargin;
    self.profileHeight = 0;
    self.contentHeight = 0;
    self.picHeight = 0;
    [self layout];
    return self;
}
- (void)layout {
    
    [self layoutProfile];
    [self layoutContent];
    [self layoutTime];
    [self layoutPicture];
    [self layoutPraiseAndCommpent];
    [self layoutTool];
}

- (void)updateDate {
    
}
- (void)layoutProfile {
    
}
- (void)layoutContent {
    
}
- (void)layoutTime {
    
}
- (void)layoutPicture {
    
}
- (void)layoutPraiseAndCommpent {
    
}
- (void)layoutTool {
    
    
}

@end
