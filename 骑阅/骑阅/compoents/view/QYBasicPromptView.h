//
//  QYBasicPromptView.h
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

@interface QYBasicPromptView : UIView
@property (nonatomic, assign) CGFloat sideMargin;
@property (nonatomic, copy) void(^closeAction)();

- (void)show;
- (void)closeView;
- (void)clickMaskView;
@end
