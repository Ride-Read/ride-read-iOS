//
//  QYOtherLoginView.m
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYOtherLoginView.h"
#import "define.h"
#import "Masonry.h"

@implementation QYOtherLoginView

#pragma mark - life cycle

-(instancetype)init {
    
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    return self;
}
#pragma mark - Priavte methods
-(void)setUpUI {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.weixin];
    [self addSubview:self.QQ];
    [self addSubview:self.weibo];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(0);
    }];
    [self.weixin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(65.7);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(22.3);
        make.width.mas_equalTo(cl_caculation_x(34.3 * 2));
        make.height.mas_equalTo(cl_caculation_y(27.7 * 2));
        
    }];
    [self.QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.weixin.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(cl_caculation_x(27.3 * 2));
        make.height.mas_equalTo(cl_caculation_y(28 *2));
        
    }];
    [self.weibo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.QQ.mas_top);
        make.width.mas_equalTo(cl_caculation_x(32 * 2));
        make.height.mas_equalTo(cl_caculation_y(29 *2));
        make.right.mas_equalTo(-65.7);
    }];
    
}

#pragma mark - targrt action
-(void)clickButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:sender.tag];
    }
    
}
#pragma mark - setters and getters
-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"----- 其他登录方式 -----";
        _titleLabel.textColor = RGB(193, 192, 192);
        _titleLabel.font = [UIFont systemFontOfSize:34 * 0.36];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}
-(UIButton *)weixin {
    
    if (!_weixin) {
        
        _weixin = [[UIButton alloc] init];
        _weixin.tag = 0;
        [_weixin setBackgroundImage:[UIImage imageNamed:@"other_login_weixin"] forState:UIControlStateNormal];
        [_weixin addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixin;
}

-(UIButton *)QQ {
    
    if (!_QQ) {
        
        _QQ = [[UIButton alloc] init];
        _QQ.tag = 1;
        [_QQ setBackgroundImage:[UIImage imageNamed:@"other_login_qq"] forState:UIControlStateNormal];
        [_QQ addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QQ;
}

-(UIButton *)weibo {
    
    if (!_weibo) {
        
        _weibo = [[UIButton alloc] init];
        _weibo.tag = 2;
        [_weibo setBackgroundImage:[UIImage imageNamed:@"other_login_weibo"] forState:UIControlStateNormal];
        [_weibo addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weibo;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
