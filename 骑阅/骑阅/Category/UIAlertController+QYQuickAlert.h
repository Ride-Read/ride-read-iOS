//
//  UIAlertController+QYQuickAlert.h
//  骑阅
//
//  Created by chen liang on 2017/4/3.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (QYQuickAlert)

+ (void)alertControler:(NSString *)title leftTitle:(NSString *)left rightTitle:(NSString *)right from:(UIViewController *)from action:(void(^)(NSUInteger index))actionHandler;
@end
