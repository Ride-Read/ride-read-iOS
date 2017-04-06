//
//  UIAlertController+QYQuickAlert.m
//  骑阅
//
//  Created by chen liang on 2017/4/3.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "UIAlertController+QYQuickAlert.h"

@implementation UIAlertController (QYQuickAlert)

+ (void)alertControler:(NSString *)title message:(NSString *)message leftTitle:(NSString *)left rightTitle:(NSString *)right from:(UIViewController *)from action:(void (^)(NSUInteger))actionHandler {
    
    if ((!left&&!right) || !from) {
        
        NSAssert(0, @"must give left or right title and from controller");
    }
    UIAlertAction *leftAction;
    UIAlertAction *rightAction;
    if (left) {
        
        leftAction = [UIAlertAction actionWithTitle:left style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            actionHandler(0);
        }];
    }
    if (right) {
        
        rightAction = [UIAlertAction actionWithTitle:right style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            actionHandler(1);
        }];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftAction) {
        
        [alert addAction:leftAction];
    }
    
    if (rightAction) {
        
        [alert addAction:rightAction];
    }
    [from presentViewController:alert animated:YES completion:nil];

    
}
@end
