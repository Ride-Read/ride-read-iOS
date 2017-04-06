//
//  QYSelectModel.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSelectModel : NSObject
/** titile */
@property (nonatomic,copy,readonly) NSString *title;
/** title 标题颜色 */
@property (nonatomic,strong,readonly) UIColor *titleColor;

/**
 定义view model

 @param title 标题
 @param titleColor 颜色

 @return 对象
 */
- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor;
/**
 定义view model
 
 @param title 标题
 @param titleColor 颜色
 
 @return 对象
 */
+ (instancetype)QYSelectModelWithTitle:(NSString *)title
                             titleColor:(UIColor *)titleColor;

@end
