//
//  QYSearchView.h
//  骑阅
//
//  Created by chen liang on 2017/3/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewClickProtocol.h"

@interface QYSearchView : UIView
@property (nonatomic, weak) id <QYSearchViewProtocol> logic;
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;

+ (instancetype)searchViewLogic:(id <QYSearchViewProtocol>) logic;
@end
