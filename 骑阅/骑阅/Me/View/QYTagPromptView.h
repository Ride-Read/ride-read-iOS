//
//  QYTagPromptView.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicPromptView.h"

@interface QYTagPromptView : QYBasicPromptView

/** title */
@property(nonatomic,strong) NSString * title;
@property (nonatomic, weak) QYUser *usr;

+ (instancetype)creatView;

+ (instancetype)tagView:(void(^)(UIView *view))clickCustom clickConfirm:(void(^)(NSString *tags))handler;

@end
