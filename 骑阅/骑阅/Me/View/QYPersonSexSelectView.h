//
//  QYPersonSexSelectView.h
//  骑阅
//
//  Created by chen liang on 2017/4/27.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicPromptView.h"
#import "QYUser.h"
@interface QYPersonSexSelectView : QYBasicPromptView
@property (nonatomic, weak) QYUser *user;
@property (nonatomic, copy) void(^handler)(NSString *sex);

+ (instancetype)loadPersonSexView:(QYUser *)user block:(void(^)(NSString *sex))block;
@end
