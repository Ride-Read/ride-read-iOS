//
//  YYFMPromptView.h
//  优悦一族
//
//  Created by 亮 on 2017/1/9.
//  Copyright © 2017年 umed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYFMPromptView : UIView
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIColor *messageColor;

+(instancetype)prompt:(NSString *)title message:(NSString *)message items:(NSArray *)array click:(void(^)(UIButton *button))block;
-(void)show;
@end
