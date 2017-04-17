//
//  QYAnnotationView.m
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAnnotationView.h"
#import "QYAnnotionModel.h"

@implementation QYAnnotationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.locaView = [QYLocationAnnotionView locaView];
    self.bounds = self.locaView.bounds;
    [self addSubview:self.locaView];
    return self;
}
+ (instancetype)annotionViewMapView:(MAMapView *)mapView {
    
    static NSString *ID = @"annotionreuser";
    QYAnnotationView *view = (QYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!view) {
        
        view = [[QYAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    return view;
    
}

- (void)setAnnotation:(id<MAAnnotation>)annotation {
    
    [super setAnnotation:annotation];
    QYAnnotionModel *annot = (QYAnnotionModel *)annotation;
    self.locaView.model = annot;
}
@end
