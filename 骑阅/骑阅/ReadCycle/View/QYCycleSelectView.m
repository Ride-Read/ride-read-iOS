//
//  QYCycleSelectView.m
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleSelectView.h"
#import "UIColor+QYHexStringColor.h"
#import "Masonry.h"

@interface QYCycleSelectView ()
@property (nonatomic, strong) UIButton *nearbyButton;
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *centerLine;

@end
@implementation QYCycleSelectView

#pragma mark - life cycle
- (instancetype)init {
    
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    return self;
}

#pragma mark - private method

- (void)setUpUI {
    
    [self addSubview:self.nearbyButton];
    [self addSubview:self.attentionButton];
    [self addSubview:self.lineView];
    [self addSubview:self.centerLine];
    [self.nearbyButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.top.and.bottom.mas_equalTo(0);
        make.right.equalTo(self.mas_centerX);
    }];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.right.and.bottom.mas_equalTo(0);
        make.left.equalTo(self.mas_centerX);
    }];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(10);
        
    }];
}

#pragma mark - target action

- (void)clickButton:(UIButton *)sender {
    
        if (sender.tag == 0) {
            
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(self.mas_centerX);
                make.height.mas_equalTo(2);
                make.bottom.mas_equalTo(0);
            }];

        } else {
            
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.right.mas_equalTo(0);
                make.left.mas_equalTo(self.mas_centerX);
                make.height.mas_equalTo(2);
                make.bottom.mas_equalTo(0);
            }];
            
        }
    [UIView animateWithDuration:0.25 animations:^{
       
        [self layoutIfNeeded];
    }];

    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:sender.tag];
    }
}

#pragma mark - getters and setters
-(UIButton *)nearbyButton {
    
    if (!_nearbyButton) {
        
        _nearbyButton = [[UIButton alloc] init];
        _nearbyButton.tag = 0;
        _nearbyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_nearbyButton setTitle:@"附近" forState:UIControlStateNormal];
        [_nearbyButton setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [_nearbyButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nearbyButton;
}
-(UIButton *)attentionButton {
    
    if (!_attentionButton) {
        
        _attentionButton = [[UIButton alloc] init];
        _attentionButton.tag = 1;
        [_attentionButton setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionButton;
}

-(UIView *)lineView {
    
    if (!_lineView) {
        
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:0.32 green:0.79 blue:0.76 alpha:1.00];
    }
    return _lineView;
}

-(UIView *)centerLine {
    
    if (!_centerLine) {
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    }
    return _centerLine;
}
@end
