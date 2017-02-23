//
//  QYResetOrSetPwdView.m
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYResetOrSetPwdView.h"
#import "Masonry.h"
#import "define.h"
#import "UIColor+QYHexStringColor.h"

@interface QYResetOrSetPwdView ()
@property (nonatomic, assign, readwrite) QYResetViewStyle style;
@end
@implementation QYResetOrSetPwdView

#pragma mark - life cycle
-(instancetype)init {

    self = [self initWithStyle:QYResetViewStyleReset];
    return self;
}
-(instancetype)initWithStyle:(QYResetViewStyle)style {
    
    _style = style;
    self = [super init];
    [self setUpUI];
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
}

#pragma mark - private method
-(void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.title];
    [self addSubview:self.pwd];
    [self addSubview:self.confirmPwd];
    [self addSubview:self.completeButton];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.and.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(85 * 2));
    }];
    [self.pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.title.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(60 * 2));
    }];
    [self.confirmPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(self.pwd.mas_bottom);
        make.height.mas_equalTo(cl_caculation_y(60 * 2));
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.confirmPwd.mas_bottom).offset(cl_caculation_y(39.3 * 2));
        make.width.mas_equalTo(cl_caculation_x(132 * 2));
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(cl_caculation_y(44 * 2));
    }];
   
    
}

#pragma mark - targert action
-(void)clickLoginButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:sender.tag];
    }
    
}

#pragma mark - setters and getters

-(QYLoginTextField *)title {
    
    if (!_title) {
        
        _title = [[QYLoginTextField alloc] init];
        if (self.style == QYResetViewStyleReset) {
            
            _title.textField.text = @"重置密码";
        } else
            _title.textField.text = @"设置密码";
        _title.textField.textColor =  [UIColor colorWithHexString:@"#555555"];
        _title.textField.enabled = NO;
        _title.textFieldCenterLeft = 15 * 2;
        _title.textFieldBottom = 0;
    }
    return _title;
}
-(QYLoginTextField *)pwd {
    
    if (!_pwd) {
        
        _pwd = [[QYLoginTextField alloc] init];
        _pwd.placeHolder = @"6~16个字符";
        _pwd.textField.secureTextEntry = YES;
        _pwd.textFieldCenterLeft = 15 * 2.5;
        if (kScreenHeight < 560) {
            
            _pwd.textFieldBottom = 6;
        } else {
            
            _pwd.textFieldBottom = 8;
        }
    }
    return _pwd;
}

-(QYLoginTextField *)confirmPwd {
    
    if (!_confirmPwd) {
        
        _confirmPwd = [[QYLoginTextField alloc] init];
        _confirmPwd.placeHolder = @"确认密码";
        _confirmPwd.textField.secureTextEntry = YES;
        _confirmPwd.textFieldCenterLeft = 15 * 2;
        if (kScreenHeight < 560) {
            
            _confirmPwd.textFieldBottom = 6;
        } else {
            
            _confirmPwd.textFieldBottom = 8;
        }
        
    }
    return _confirmPwd;
}
-(UIButton *)completeButton {
    
    if (!_completeButton) {
        
        _completeButton = [[UIButton alloc] init];
        _completeButton.tag = 0;
        if (self.style == QYResetViewStyleReset) {
            
            [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        } else
            [_completeButton setTitle:@"下一步" forState:UIControlStateNormal];


        [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_completeButton setBackgroundImage:[UIImage imageNamed:@"log_button_radiu"] forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}


@end
