//
//  QYPictureLookView.m
//  骑阅
//
//  Created by chen liang on 2017/3/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPictureLookView.h"
#import "define.h"

@interface QYPictureLookView()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGRect qy_frame;
@property (nonatomic, strong) UIImageView *detImageView;
@end

@implementation QYPictureLookView

+ (instancetype)pictureLookViewWithImageView:(UIImageView *)imageView frame:(CGRect)frame{
    
    return [[self alloc] initWithImageView:imageView frame:frame];
}
- (instancetype)initWithImageView:(UIImageView *)imageView frame:(CGRect)frame{
    
    self = [super init];
    self.imageView = imageView;
    self.qy_frame = frame;
    self.detImageView = [[UIImageView alloc] initWithImage:imageView.image];
    self.detImageView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    [self addSubview:self.detImageView];
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
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    [window addSubview:_maskView];
    [window addSubview:self];
    self.frame = self.qy_frame;
    self.detImageView.frame = self.bounds;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(0, 80, kScreenWidth, kScreenHeight - 160);
        self.detImageView.frame = self.bounds;
        
    } completion:nil];
    
}
- (void)closeView
{
 
    self.maskView.frame = self.frame;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectOffset(self.qy_frame, 0, 64);
        self.detImageView.frame = self.bounds;
        self.maskView.frame = self.frame;
        
    } completion:^(BOOL finished) {
        
        [UIView setAnimationsEnabled:NO];
        [self.maskView removeFromSuperview];
        self.maskView = nil;
        [self removeFromSuperview];
        [UIView setAnimationsEnabled:YES];
    }];
}

#pragma mark - target action

- (void)clickMaskView {
    
    [self closeView];
}


@end
