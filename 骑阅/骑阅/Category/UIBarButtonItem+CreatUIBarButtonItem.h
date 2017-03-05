//
//  UIBarButtonItem+CreatUIBarButtonItem.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CreatUIBarButtonItem)

/** 快速创建BarButtonItem：normal + highLight */
+(UIBarButtonItem *)creatItemWithImage:(NSString *)imageName highLightImage:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
