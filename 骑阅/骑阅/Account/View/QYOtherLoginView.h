//
//  QYOtherLoginView.h
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewClickProtocol.h"

@interface QYOtherLoginView : UIView
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *weixin;
@property (nonatomic, strong) UIButton *QQ;
@property (nonatomic, strong) UIButton *weibo;

@end
