//
//  QYMapSignView.h
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewClickProtocol.h"

@interface QYMapSignView : UIView
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;

+ (instancetype)signView;
@end
