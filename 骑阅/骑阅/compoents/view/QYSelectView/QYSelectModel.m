//
//  QYSelectModel.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSelectModel.h"

#define DEFAULT_TITLE_COLOR [UIColor blackColor]

@implementation QYSelectModel

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    
    if (self = [super  init]){
        
        _title = title;
        _titleColor = titleColor ? titleColor : DEFAULT_TITLE_COLOR;
    }
    return self;
}

+ (instancetype)QYSelectModelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    
    return [[QYSelectModel alloc] initWithTitle:title titleColor:titleColor];
}
@end
