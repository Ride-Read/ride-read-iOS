//
//  QYAcountTextFiled.m
//  骑阅
//
//  Created by chen liang on 2017/5/8.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYAcountTextFiled.h"

@implementation QYAcountTextFiled

- (instancetype)init {
    
    self = [super init];
    self.placeHolderRect = CGRectZero;
    self.leftMargin = 0.;
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.placeHolderRect = CGRectZero;
    self.leftMargin = 0.;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    CGRect rect = [super placeholderRectForBounds:bounds];
    rect = CGRectOffset(rect, self.leftMargin, 0);
    return rect;
}

- (void)setLeftMargin:(CGFloat)leftMargin  {
    
    _leftMargin = leftMargin;
    [self setNeedsLayout];
}
- (void)setPlaceHolderRect:(CGRect)placeHolderRect {
    
    _placeHolderRect = placeHolderRect;
    [self setNeedsDisplay];
}

@end
