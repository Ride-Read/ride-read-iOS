//
//  QYButtonSheetPromptView.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYButtonSheetPromptView.h"
#import "UIButton+QYTitleButton.h"
#import "UIColor+QYHexStringColor.h"
#import "define.h"

@interface QYButtonSheetPromptView ()

@property (nonatomic, copy) void(^action)(UIButton *);
@end

@implementation QYButtonSheetPromptView


+ (instancetype)promptWithButtonTitles:(NSArray *)titles action:(void (^)(UIButton *))action {
    
    return [[self alloc] initWithTitles:titles action:action];
}
- (instancetype)initWithTitles:(NSArray *)titles action:(void (^)(UIButton *))action {
    
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    self.action = action;
    UIButton *pre;
    for (NSInteger i = 0 ;i < titles.count;i ++) {
        
        NSString *title = titles[i];
        UIButton *button = [UIButton buttonTitle:title font:16 colco:[UIColor colorWithHexString:@"#555555"]];
        [self addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        if (!pre) {
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.and.right.and.top.mas_equalTo(0);
                make.height.mas_equalTo(60);
            }];
            
        } else {
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(pre.mas_bottom);
                make.left.and.right.mas_equalTo(0);
                make.height.mas_equalTo(60);
            }];
            
        }
        if (i != titles.count - 1) {
            
            [button showBottomLine];
        }
        pre = button;
    }
    CGRect frame = CGRectZero;
    frame.origin.x = self.sideMargin;
    frame.origin.y = kScreenHeight/2 - 60 * titles.count/2.0;
    frame.size.width = kScreenWidth - self.sideMargin * 2;
    frame.size.height = titles.count * 60;
    self.frame = frame;
    return self;
}
#pragma mark - tagart action

- (void)clickButton:(UIButton *)sender {
    
    if (self.action) {
        
        self.action(sender);
        [self closeView];
    }
}
#pragma mark
- (CGFloat)sideMargin {
    
    return cl_caculation_3x(96);
}

@end
