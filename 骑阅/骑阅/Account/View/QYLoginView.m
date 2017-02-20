//
//  QYLoginView.m
//  骑阅
//
//  Created by 亮 on 2017/2/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginView.h"
#import "Masonry.h"
#import "define.h"
#import "UIColor+QYHexStringColor.h"

@implementation QYLoginView

#pragma mark - life cycle
-(instancetype)init {
    
    self = [super init];
    [self setUpUI];
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    self.forgetButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - private method
-(void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginButton];
    [self addSubview:self.forgetButton];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(65.7 * 2));
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(self.phoneTextField.mas_bottom);
        make.height.mas_equalTo(cl_caculation_y(57 * 2));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(cl_caculation_y(69.3 * 2));
        make.width.mas_equalTo(cl_caculation_x(132 * 2));
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(cl_caculation_y(44 * 2));
    }];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX).offset(2);
        make.top.equalTo(self.loginButton.mas_bottom).offset(13);
        make.height.mas_equalTo(16);
    }];
    
}

#pragma mark - targert action
-(void)clickLoginButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:sender.tag];
    }
    
}

#pragma mark - setters and getters
-(QYLoginTextField *)phoneTextField {
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[QYLoginTextField alloc] init];
        _phoneTextField.placeHolder = @"手机 / 骑阅号";
        _phoneTextField.textFieldCenterLeft = 15 * 3;
        _phoneTextField.textFieldBottom = 0;
    }
    return _phoneTextField;
}

-(QYLoginTextField *)passwordTextField {
    
    if (!_passwordTextField) {
        
        _passwordTextField = [[QYLoginTextField alloc] init];
        _passwordTextField.placeHolder = @"输入密码";
        _passwordTextField.textFieldCenterLeft = 15 * 2;
        if (kScreenHeight < 560) {
            
            _passwordTextField.textFieldBottom = 7;
        } else {
            
            _passwordTextField.textFieldBottom = 9;
        }

    }
    return _passwordTextField;
}
-(UIButton *)loginButton {
    
    if (!_loginButton) {
        
        _loginButton = [[UIButton alloc] init];
        _loginButton.tag = 0;
        [_loginButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"log_button_radiu"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(UIButton *)forgetButton {
    
    if (!_forgetButton) {
        
        _forgetButton = [[UIButton alloc] init];
        _forgetButton.tag = 1;
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}


@end
