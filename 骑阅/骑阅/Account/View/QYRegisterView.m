//
//  QYRegisterView.m
//  骑阅
//
//  Created by 亮 on 2017/2/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRegisterView.h"
#import "define.h"
#import "Masonry.h"
#import "UIColor+QYHexStringColor.h"

@implementation QYRegisterView

-(instancetype)init {
    
    self = [super init];
    [self setUpUI];
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    self.protocolButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark - targert action
-(void)clickLoginButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:sender.tag];
    }
    
}

#pragma mark - private method
-(void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.verifyTextField];
    [self addSubview:self.nextButton];
    [self addSubview:self.protocolButton];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(65.7 * 2));
    }];
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(self.phoneTextField.mas_bottom);
        make.height.mas_equalTo(cl_caculation_y(57 * 2));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.verifyTextField.mas_bottom).offset(cl_caculation_y(69.3 * 2));
        make.width.mas_equalTo(cl_caculation_x(132 * 2));
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(cl_caculation_y(44 * 2));
    }];
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(2);
        make.top.equalTo(self.nextButton.mas_bottom).offset(13);
        make.height.mas_equalTo(16);
    }];
    
}


#pragma mark - setters and getters
-(QYLoginTextField *)phoneTextField {
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[QYLoginTextField alloc] init];
        _phoneTextField.placeHolder = @"输入手机号";
        _phoneTextField.textFieldLeft = 15 * 2.5;
        _phoneTextField.textFieldBottom = 0;
    }
    return _phoneTextField;
}

-(QYLoginTextField *)verifyTextField {
    
    if (!_verifyTextField) {
        
        _verifyTextField = [[QYLoginTextField alloc] init];
        _verifyTextField.placeHolder = @"输入验证码";
        _verifyTextField.textFieldLeft = 15 * 6;
        _verifyTextField.textFieldBottom = 9;
        
    }
    return _verifyTextField;
}

-(UIButton *)nextButton {
    
    if (!_nextButton) {
        
        _nextButton = [[UIButton alloc] init];
        _nextButton.tag = 0;
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"log_button_radiu"] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
-(UIButton *)protocolButton {
    
    if (!_protocolButton) {
        
        _protocolButton = [[UIButton alloc] init];
        _protocolButton.tag = 1;
        _protocolButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意骑阅用户协议"];
        [string setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#C1C0C0"]} range:NSMakeRange(0, 7)];
        [string setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"]} range:NSMakeRange(7, 6)];
        _protocolButton.titleLabel.attributedText = string;
        [_protocolButton setAttributedTitle:string forState:UIControlStateNormal];
        [_protocolButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolButton;
}


@end
