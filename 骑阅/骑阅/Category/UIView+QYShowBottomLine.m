//
//  UIView+QYShowBottomLine.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "UIView+QYShowBottomLine.h"
#import "define.h"

@implementation UIView (QYShowBottomLine)

- (void)showBottomLine {
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}
@end
