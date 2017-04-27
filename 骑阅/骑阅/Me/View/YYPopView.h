//
//  YYPopView.h
//  优悦一族
//
//  Created by 蒋永忠 on 16/4/6.
//  Copyright © 2016年 umed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYBasicPromptView.h"

@interface YYPopView : QYBasicPromptView
@property (nonatomic, weak) QYUser *user;
@property (nonatomic, copy) void(^handler)(NSString *age);
+ (instancetype)popViewUser:(QYUser *)user handler:(void(^)(NSString *age))handler;
@end
