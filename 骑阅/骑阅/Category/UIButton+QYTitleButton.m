//
//  UIButton+QYTitleButton.m
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "UIButton+QYTitleButton.h"

@implementation UIButton (QYTitleButton)

+ (instancetype)buttonTitle:(NSString *)title font:(CGFloat)font colco:(UIColor *)color {
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}
@end
