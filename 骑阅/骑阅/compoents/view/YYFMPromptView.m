//
//  YYFMPromptView.m
//  优悦一族
//
//  Created by 亮 on 2017/1/9.
//  Copyright © 2017年 umed. All rights reserved.
//

#import "YYFMPromptView.h"
#import "Masonry.h"
#import "define.h"

@interface YYFMPromptView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) void(^blcok)(UIButton *);

@end
@implementation YYFMPromptView

+(instancetype)prompt:(NSString *)title message:(NSString *)message items:(NSArray *)array click:(void (^)(UIButton *))block {
    
    
    return [[self alloc] initWithTitle:title message:message items:array click:block];
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)array click:(void (^)(UIButton *))block {
    
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8.0;
    [self addSubview:self.titleLabel];
    self.titleLabel.text = title;
    [self addSubview:self.detailLabel];
    self.detailLabel.text = message;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    UIButton *pre;
    if (array.count == 1) {
        
        pre = [[UIButton alloc] init];
        [pre setTitle:array[0] forState:UIControlStateNormal];
        pre.titleLabel.font = [UIFont systemFontOfSize:17];
        pre.titleLabel.textAlignment = NSTextAlignmentCenter;
        [pre setTitleColor:[UIColor colorWithRed:0.43 green:0.65 blue:0.22 alpha:1.00] forState:UIControlStateNormal];
        [pre addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        //WEAKSELF(_self);
        [self addSubview:pre];
        [pre mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
            make.left.and.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.bottom.equalTo(self.mas_bottom);
        }];
    
    } else {
        
        pre = [[UIButton alloc] init];
        [pre setTitle:array[0] forState:UIControlStateNormal];
        pre.titleLabel.font = [UIFont systemFontOfSize:17];
        pre.titleLabel.textAlignment = NSTextAlignmentCenter;
        [pre addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [pre setTitleColor:[UIColor colorWithRed:0.43 green:0.65 blue:0.22 alpha:1.00] forState:UIControlStateNormal];
        //WEAKSELF(_self);
        [self addSubview:pre];
        pre.tag = 0;
        [pre mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.bottom.equalTo(self.mas_bottom);
        }];
    
        
        UIButton *next = [[UIButton alloc] init];
        [next setTitle:array[1] forState:UIControlStateNormal];
        next.titleLabel.font = [UIFont systemFontOfSize:17];
        next.titleLabel.textAlignment = NSTextAlignmentCenter;
        [next setTitleColor:[UIColor colorWithRed:0.43 green:0.65 blue:0.22 alpha:1.00] forState:UIControlStateNormal];
        [self addSubview:next];
        next.tag = 1;
        [next addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.detailLabel.mas_bottom).offset(5);
            make.left.equalTo(pre.mas_right);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(pre.mas_width);
        }];

    }

    self.blcok = block;
    return self;
}
-(void)dealloc {
    
    MyLog(@"prompt dealloc");
}
#pragma mark - Pblic method
-(void)show {
    
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc] initWithFrame:window.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:0.5];
    [window addSubview:_maskView];
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(window.mas_centerY);
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(25);
    }];
    
}
#pragma mark - target action

-(void)setTitleColor:(UIColor *)titleColor {
    
    self.titleLabel.textColor = titleColor;
}

-(void)setMessageColor:(UIColor *)messageColor {
    
    self.detailLabel.textColor = messageColor;
}
-(void)clickButton:(UIButton *)button {
    
    if (self.blcok) {
        
        self.blcok(button);
    }
    [self closeView];
}

-(void)closeView
{
    
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    [self removeFromSuperview];
}

#pragma mark - setters and getters
-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor colorWithRed:0.43 green:0.65 blue:0.22 alpha:1.00];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)detailLabel {
    
    if (!_detailLabel) {
        
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
    
}

@end
