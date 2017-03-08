//
//  UIBarButtonItem+CreatUIBarButtonItem.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "UIBarButtonItem+CreatUIBarButtonItem.h"

@implementation UIBarButtonItem (CreatUIBarButtonItem)

/** 快速创建BarButtonItme：normal + highLight */
+(UIBarButtonItem *)creatItemWithImage:(NSString *)imageName highLightImage:(NSString *)highImageName title:(NSString *) title target:(id)target action:(SEL)action {

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * contentView = [[UIView alloc]initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:contentView];
    return item;
}

@end
