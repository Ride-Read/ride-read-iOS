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

@interface QYRegisterView ()
@property (nonatomic, strong) UIView *centerLine;
@property (nonatomic, strong) UIButton *codeButton;

@end
@implementation QYRegisterView

-(instancetype)init {
    
    self = [super init];
    [self setUpUI];
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    self.protocolButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.codeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
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
    [self addSubview:self.centerLine];
    [self.verifyTextField addSubview:self.codeButton];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(65.7 * 2));
    }];
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.equalTo(self.phoneTextField.mas_bottom);
        make.height.mas_equalTo(cl_caculation_y(57 * 2));
        make.right.mas_equalTo(0);
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
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(1);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(cl_caculation_y(32));
        make.bottom.equalTo(self.verifyTextField.mas_bottom).offset(-cl_caculation_y(32));
        
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.verifyTextField.mas_centerX).offset(18);
        make.centerY.equalTo(self.verifyTextField.textField.mas_centerY);
        
    }];
    
}


#pragma mark - setters and getters
-(QYLoginTextField *)phoneTextField {
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[QYLoginTextField alloc] init];
        _phoneTextField.placeHolder = @"输入手机号";
        _phoneTextField.type = UIKeyboardTypeNumberPad;
        _phoneTextField.textFieldCenterLeft = 15 * 2.5;
        _phoneTextField.textFieldBottom = 0;
    }
    return _phoneTextField;
}

-(QYLoginTextField *)verifyTextField {
    
    if (!_verifyTextField) {
        
        _verifyTextField = [[QYLoginTextField alloc] init];
        _verifyTextField.placeHolder = @"输入验证码";
        _verifyTextField.type = UIKeyboardTypeNumberPad;
        _verifyTextField.textFieldCenterLeft = 15 * 6;
        
        if (kScreenHeight < 560) {
            
            _verifyTextField.textFieldBottom = 4;
        } else {
           
            _verifyTextField.textFieldBottom = 6;
        }
        
        
    }
    return _verifyTextField;
}
-(UIView *)centerLine {
    
    if (!_centerLine) {
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    }
    return _centerLine;
}

-(UIButton *)codeButton {
    
    if (!_codeButton) {
        
        _codeButton = [[UIButton alloc] init];
        _codeButton.tag = 0;
        [_codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_codeButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeButton;
}

-(UIButton *)nextButton {
    
    if (!_nextButton) {
        
        _nextButton = [[UIButton alloc] init];
        _nextButton.tag = 1;
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
        _protocolButton.tag = 2;
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

-(void)setType:(QYRegisterOrForgertType)type {
    
    _type = type;
    if (type == QYForgertViewType) {
        
        self.protocolButton.hidden = YES;
    } else {
        self.protocolButton.hidden = NO;
    }
}

@end
