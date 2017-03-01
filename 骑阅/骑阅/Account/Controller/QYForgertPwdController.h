//
//  QYForgertPwdController.h
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"

@protocol QYControllerDismissAciton <NSObject>

-(void)customTransitonDissmiss:(UIViewController *)controller;

@end
@interface QYForgertPwdController :QYBasicViewController
@property (nonatomic, assign) id <QYControllerDismissAciton> delegate;

@end
