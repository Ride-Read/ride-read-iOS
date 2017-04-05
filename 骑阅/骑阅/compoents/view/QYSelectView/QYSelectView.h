//
//  QYSelectView.m
//  骑阅
//
//  Created by 谢升阳 on 2017/4/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYSelectModel.h"

@class QYSelectView;

typedef void (^QYSelectViewBlock)(QYSelectView *selectView,NSInteger index,NSString * selectedTitle);

@interface QYSelectView : UIView

+ (void)QY_showSelectViewWithTitle:(NSString *)title
                 cancelButttonTitle:(NSString *)cancelButtonTitle
                      actionContent:(NSArray<QYSelectModel *>*)actionContent
                        selectBlock:(QYSelectViewBlock)selectBlock;

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
                 actonContent:(NSArray<QYSelectModel *>*)actionContent
                  selectBlock:(QYSelectViewBlock)selectBlock;
@end
