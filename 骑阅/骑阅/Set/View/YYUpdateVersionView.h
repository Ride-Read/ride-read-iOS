//
//  YYUpdateVersionView.h
//  优悦一族
//
//  Created by liang on 2017/4/14.
//  Copyright © 2017年 umed. All rights reserved.
//

#import "QYBasicPromptView.h"

@interface YYUpdateVersionView : QYBasicPromptView
@property (nonatomic, copy) NSString *updateText;

+ (instancetype)loadUpdatePromptView:(void(^)(NSInteger index))action;

@end
