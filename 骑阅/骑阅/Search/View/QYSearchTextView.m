//
//  QYSearchTextView.m
//  骑阅
//
//  Created by chen liang on 2017/4/29.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSearchTextView.h"

@implementation QYSearchTextView



- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    return  CGRectMake(18, 3,10 * 13  + 10, bounds.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
