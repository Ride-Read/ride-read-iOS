//
//  UIButton+QYTitleButton.h
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIButton (QYTitleButton)


/**
 创建一个只带文字的Button,设置title font color

 @param title title
 @param font font
 @param color color
 @return button
 */
+ (instancetype)buttonTitle:(NSString *)title font:(CGFloat)font colco:(UIColor *)color;
@end
