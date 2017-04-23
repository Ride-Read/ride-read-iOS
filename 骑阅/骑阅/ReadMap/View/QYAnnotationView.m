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

+ (instancetype)annotionViewMapView:(MAMapView *)mapView {
    
    static NSString *ID = @"annotionreuser";
    QYAnnotationView *annoView = (QYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!annoView) {
        
        annoView = [[QYAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        
    }
    return annoView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:self animated:animated];
}
- (void)setSelected:(BOOL)selected {
    
    if (self.selected == selected) {
        
        return;
    }
    [super setSelected:selected];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    BOOL inside = [super pointInside:point withEvent:event];
    if (inside) {
        
        self.selected = YES;
    }
    return inside;
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.locaView = [QYLocationAnnotionView locaView];
        self.bounds = self.locaView.bounds;
        self.canShowCallout = YES;
        [self addSubview:self.locaView];
    }
    return self;
}
- (void)setAnnotation:(id<MAAnnotation>)annotation {
    
    [super setAnnotation:annotation];
    QYAnnotionModel *annot = (QYAnnotionModel *)annotation;
    self.locaView.model = annot;
}
@end
