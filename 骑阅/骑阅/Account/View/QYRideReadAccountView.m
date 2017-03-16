//
//  QYRideReadAccountView.m
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYRideReadAccountView.h"
#import "UIColor+QYHexStringColor.h"
#import "Masonry.h"
#import "define.h"

@interface QYIconView ()


@end
@implementation QYIconView

#pragma mark -life cycle
- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(48, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - 48, self.bounds.size.height)];
    self.bottomLine.path = path.CGPath;

    self.icon.layer.cornerRadius = cl_caculation_x(90);
}

#pragma mark - targat action

- (void)clickIconView:(UIButton *)sender {
    
    if ([self.rideReadView.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        [self.rideReadView.delegate clickCustomView:self.rideReadView index:0];
    }
}

#pragma mark - priavte method

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.icon];
    [self.icon addSubview:self.title];
    [self.layer addSublayer:self.bottomLine];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(cl_caculation_y(36 * 2));
        make.centerX.equalTo(self.mas_centerX);
        make.width.and.height.mas_equalTo(cl_caculation_x(90 * 2));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.icon.mas_centerX);
        make.centerY.equalTo(self.icon.mas_centerY);
    }];
    
}
#pragma mark - setters and getters
- (UIButton *)icon {
    
    if (!_icon) {
        
        _icon = [[UIButton alloc] init];
        _icon.backgroundColor = [UIColor colorWithRed:0.35 green:0.79 blue:0.75 alpha:1.00];
        [_icon addTarget:self action:@selector(clickIconView:) forControlEvents:UIControlEventTouchUpInside];
        _icon.layer.masksToBounds = YES;
        
    }
    return _icon;
}
-(UILabel *)title {
    
    if (!_title) {
        
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont systemFontOfSize:15.5];
        _title.text = @"头像";
    }
    return _title;
}

- (CAShapeLayer *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [[CAShapeLayer alloc] init];
        _bottomLine.lineWidth = 1.0;
        _bottomLine.strokeColor = [UIColor colorWithHexString:@"#EEEEEE"].CGColor;
    }
    return _bottomLine;
}
@end
@implementation QYRideReadAccountView

#pragma mark - life cycle
- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

#pragma mark - targert action
- (void)clickLoginButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:sender.tag];
    }
    
}
#pragma mark - Private method
- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.icon];
    [self addSubview:self.inviteCodeView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.completeButton];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(150 * 2));
    }];
    [self.inviteCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.icon.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(58 * 2));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.inviteCodeView.mas_bottom).offset(11);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.titleLabel.mas_bottom).offset(cl_caculation_y(26 * 2));
        make.width.mas_equalTo(cl_caculation_x(132 * 2));
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(cl_caculation_y(44 * 2));
        
    }];
}

#pragma mark - Public method
-(void)setIconImage:(UIImage *)image {
    
    [self.icon.icon setBackgroundImage:image forState:UIControlStateNormal];
    self.icon.title.hidden = YES;
}

#pragma mark - Setters and getters

- (QYIconView *)icon {
    
    if (!_icon) {
        
        _icon = [[QYIconView alloc] init];
        _icon.rideReadView = self;
    }
    return _icon;
}
- (QYLoginTextField *)inviteCodeView {
    
    if (!_inviteCodeView) {
        
        _inviteCodeView = [[QYLoginTextField alloc] init];
        _inviteCodeView.placeHolder = @"3~20个字符";
        _inviteCodeView.textFieldCenterLeft = 15 * 2.5;
        if (kScreenHeight < 560) {
            
            _inviteCodeView.textFieldBottom = 6;
        } else {
            
            _inviteCodeView.textFieldBottom = 8;
        }
    }
    return _inviteCodeView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"确定 骑阅号，保存后无法修改"];
        [string addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, string.length)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#555555"] range:NSMakeRange(0, string.length)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#000000"] range:NSMakeRange(3, 3)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.attributedText = string;
        
    }
    return _titleLabel;
}

- (UIButton *)completeButton {
    
    if (!_completeButton) {
        
        _completeButton = [[UIButton alloc] init];
        _completeButton.tag = 1;
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_completeButton setBackgroundImage:[UIImage imageNamed:@"log_button_radiu"] forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}


@end
