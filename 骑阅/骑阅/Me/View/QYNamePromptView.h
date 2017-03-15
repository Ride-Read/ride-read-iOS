//
//  QYNamePromptView.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicPromptView.h"
#import "YYTextView.h"

@interface QYNamePromptView : QYBasicPromptView

/** title */
@property(nonatomic,strong) NSString * title;

+ (instancetype)creatView;

@end
