//
//  QYBasicPromptView.m
//  骑阅
//
//  Created by chen liang on 2017/3/14.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicPromptView.h"

@interface QYBasicPromptView ()
@property (nonatomic, strong) UIView *maskView;
@end
@implementation QYBasicPromptView
- (instancetype)init {
    
    self = [super init];
    self.layer.cornerRadius = 5;
    return self;
}
- (void)dealloc {

    MyLog(@"%@",[self class]);
}
#pragma mark - Pblic method
- (void)show {
    
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc] initWithFrame:window.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMaskView)];
    [self.maskView addGestureRecognizer:tap];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [window addSubview:_maskView];
    [window addSubview:self];
    
}
- (void)closeView
{
    
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    [self removeFromSuperview];
}

#pragma mark - target action

- (void)clickMaskView {
    
    [self closeView];
}

#pragma mark - getter and setter

- (CGFloat)size {
    
    NSAssert(0, @"subclass must rewrite this method");
    return 0;
}

@end
