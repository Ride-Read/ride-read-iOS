//
//  QYInviteView.h
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYLoginTextField.h"
#import "QYViewClickProtocol.h"

@interface QYInviteView : UIView
@property (nonatomic, strong) QYLoginTextField *invite;
@property (nonatomic, strong) QYLoginTextField *invitePeople;
@property (nonatomic, strong) UIButton *nextSetup;
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;
@end
