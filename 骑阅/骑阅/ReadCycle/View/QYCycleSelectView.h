//
//  QYCycleSelectView.h
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewClickProtocol.h"

@interface QYCycleSelectView : UIView
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;

@end
