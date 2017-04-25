//
//  QYSigeAnnotionView.m
//  骑阅
//
//  Created by chen liang on 2017/4/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSigeAnnotionView.h"

@implementation QYSigeAnnotionView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.number.hidden = YES;
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
