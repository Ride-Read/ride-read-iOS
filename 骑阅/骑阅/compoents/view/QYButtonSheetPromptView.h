//
//  QYButtonSheetPromptView.h
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicPromptView.h"

@interface QYButtonSheetPromptView : QYBasicPromptView

+ (instancetype)promptWithButtonTitles:(NSArray *)titles action:(void(^)(UIButton *button))action;

@end
