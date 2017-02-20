//
//  QYRideReadAccountView.h
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYLoginTextField.h"
#import "QYViewClickProtocol.h"

@class QYRideReadAccountView;
@interface QYIconView : UIView
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) CAShapeLayer *bottomLine;
@property (nonatomic, weak) QYRideReadAccountView *rideReadView;

@end
@interface QYRideReadAccountView : UIView
@property (nonatomic, strong) QYIconView *icon;
@property (nonatomic, strong) QYLoginTextField *inviteCodeView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;

-(void)setIconImage:(UIImage *)image;


@end
