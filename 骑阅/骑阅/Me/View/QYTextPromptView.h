//
//  QYTextPromptView.h
//  骑阅
//
//  Created by 谢升阳 on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicPromptView.h"
#import "YYTextView.h"

@interface QYTextPromptView : QYBasicPromptView

//定义一个block
typedef void(^ConfigClickBlock)(NSString * targetString);

/** title */
@property(nonatomic,strong) NSString * title;
/** placeHolder */
@property(nonatomic,strong) NSString * placeHolder;

/** inputTextField */
@property(nonatomic,strong) UITextField * inputTextField;

@property (nonatomic, assign) NSInteger maxLength;

+ (instancetype)creatView;

//定义点击按钮block
- (void)ConfigClickWithBlock:(ConfigClickBlock)block;
@end
