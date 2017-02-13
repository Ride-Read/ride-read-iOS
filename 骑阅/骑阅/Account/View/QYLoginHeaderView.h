//
//  QYLoginHeaderView.h
//  骑阅
//
//  Created by chen liang on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewClickProtocol.h"

@interface QYLoginHeaderView : UIView
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *logButton;
@property (nonatomic, strong) UIButton *registButton;

@end
