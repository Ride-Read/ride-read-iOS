//
//  QYQYPersonAnnoationView.m
//  骑阅
//
//  Created by chen liang on 2017/4/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPersonAnnoationView.h"

@implementation QYPersonAnnoationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.annotation = annotation;
        self.locaView = [QYCustomPersonView loadPersonAnnoCus];
        self.bounds = self.locaView.bounds;
        [self addSubview:self.locaView];
    }
    return self;
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
