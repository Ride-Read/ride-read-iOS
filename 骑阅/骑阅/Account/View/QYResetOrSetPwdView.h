//
//  QYResetOrSetPwdView.h
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYLoginTextField.h"
#import "QYViewClickProtocol.h"

typedef NS_ENUM(NSUInteger,QYResetViewStyle) {
    
    QYResetViewStyleReset,
    QYResetViewStyleSet
};
@interface QYResetOrSetPwdView : UIView
@property (nonatomic, strong) QYLoginTextField *title;
@property (nonatomic, strong) QYLoginTextField *pwd;
@property (nonatomic, strong) QYLoginTextField *confirmPwd;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;
@property (nonatomic, assign, readonly) QYResetViewStyle style;

-(instancetype)initWithStyle:(QYResetViewStyle)style;
@end
