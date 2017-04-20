//
//  QYQYPersonAnnoationView.m
//  骑阅
//
//  Created by chen liang on 2017/4/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonAnnoationView.h"

@implementation QYPersonAnnoationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.locaView = [QYCustomPersonView loadPersonAnnoCus];
    self.bounds = self.locaView.bounds;
    [self addSubview:self.locaView];
    return self;
}
+ (instancetype)personAnnotionViewMapView:(MAMapView *)mapView {
    
    static NSString *ID = @"personAnno";
    QYPersonAnnoationView *anno = (QYPersonAnnoationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!anno) {
        
        anno = [[QYPersonAnnoationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    return anno;
    
}

- (void)setAnnotation:(id<MAAnnotation>)annotation {
    
    [super setAnnotation:annotation];
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
