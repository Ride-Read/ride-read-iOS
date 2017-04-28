//
//  QYProfessionViewController.h
//  骑阅
//
//  Created by 谢升阳 on 2017/4/28.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"

@class QYProfessionViewController;

@protocol QYProfessionDelegate <NSObject>

- (void)viewController:(QYProfessionViewController *) viewController didFinishSelectedProfession:(NSString *)profession;

@end

@interface QYProfessionViewController : QYBasicViewController

/** delegate */
@property(nonatomic,weak) id<QYProfessionDelegate> delegate;

@end
