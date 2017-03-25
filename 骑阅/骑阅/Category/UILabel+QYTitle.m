//
//  UILabel+QYTitle.m
//  骑阅
//
//  Created by chen liang on 2017/3/25.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "UILabel+QYTitle.h"
#import "UIColor+QYHexStringColor.h"

@implementation UILabel (QYTitle)

+ (instancetype)lableTitle:(NSString *)title font:(CGFloat)font color:(NSString *)color {
    
    UILabel *label = [[UILabel alloc] init];
    label.text= title;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:color];
    return label;
}

@end
