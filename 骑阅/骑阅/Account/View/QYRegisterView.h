//
//  QYRegisterView.h
//  骑阅
//
//  Created by 亮 on 2017/2/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYLoginTextField.h"
#import "QYViewClickProtocol.h"

@interface QYRegisterView : UIView
@property (nonatomic, strong) QYLoginTextField *phoneTextField;
@property (nonatomic, strong) QYLoginTextField *verifyTextField;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *protocolButton;
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;
@end
