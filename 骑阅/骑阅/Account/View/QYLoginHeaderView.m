//
//  QYLoginHeaderView.m
//  骑阅
//
//  Created by chen liang on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginHeaderView.h"
#import "Masonry.h"
#import "define.h"

@interface QYLoginHeaderView ()
@property (nonatomic, strong) CAShapeLayer *logTriangle;
@property (nonatomic, strong) CAShapeLayer *registertriangle;

@end
@implementation QYLoginHeaderView

#pragma mark - life cycle
-(instancetype)init {
    
    self = [super init];
    [self setUpUI];
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat log_weiht = self.logButton.bounds.size.width;
    CGFloat log_height = self.logButton.bounds.size.height;
    CGPoint log_left = CGPointMake(log_weiht/2 - 6, log_height);
    CGPoint log_right = CGPointMake(log_weiht/2 + 6, log_height);
    CGPoint log_top = CGPointMake(log_weiht/2, log_height - 8);
    [path moveToPoint:log_left];
    [path addLineToPoint:log_top];
    [path addLineToPoint:log_right];
    [path addLineToPoint:log_left];
    self.logTriangle.path = path.CGPath;
    
    UIBezierPath *re_path = [[UIBezierPath alloc] init];
    CGFloat re_weiht = self.registButton.bounds.size.width;
    CGFloat re_height = self.registButton.bounds.size.height;
    CGPoint re_left = CGPointMake(re_weiht/2 - 6, re_height);
    CGPoint re_right = CGPointMake(re_weiht/2 + 6, re_height);
    CGPoint re_top = CGPointMake(re_weiht/2, re_height - 8);
    [re_path moveToPoint:re_left];
    [re_path addLineToPoint:re_top];
    [re_path addLineToPoint:re_right];
    [re_path addLineToPoint:re_left];
    self.registertriangle.path = re_path.CGPath;
    
}

#pragma mark - Priavte method
-(void)setUpUI {
    
    [self addSubview:self.bgView];
    //    [self addSubview:self.titleLabel];
    [self addSubview:self.QYLogoImageView];
    [self addSubview:self.logButton];
    [self addSubview:self.registButton];
    [self addSubview:self.QYLogoImageView];
    [self.logButton.layer addSublayer:self.logTriangle];
    [self.registButton.layer addSublayer:self.registertriangle];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.and.bottom.mas_equalTo(0);
    }];
    [self.QYLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(cl_caculation_y(57 * 2));
        make.height.mas_equalTo(cl_caculation_y(30 * 2));
        make.width.mas_equalTo(cl_caculation_x(64 * 2));
    }];
    
    //    [self.QYLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.centerX.equalTo(self.mas_centerX);
    //        make.top.mas_equalTo(cl_caculation_y(57 * 2));
    //    }];
    
    [self.logButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(45);
        make.right.equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_centerX);
        make.right.mas_equalTo(-45);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    
}
#pragma mark - targart action

-(void)clickButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        if (sender.tag == 0) {
            
            if (!self.logTriangle.hidden) {
                return;
            }
            self.logTriangle.hidden = NO;
            self.registertriangle.hidden = YES;
            
        } else {
            if (!self.registertriangle.hidden) {
                
                return;
            }
            self.registertriangle.hidden = NO;
            self.logTriangle.hidden = YES;
        }
        [self.delegate clickCustomView:self index:sender.tag];
    }
}
#pragma mark - setters and getters

-(UIImageView *)bgView {
    
    if (!_bgView) {
        
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"login_back_image"];
    }
    return _bgView;
}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"骑阅";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:35];
        
    }
    return _titleLabel;
}

-(UIImageView *)QYLogoImageView {
    
    if (!_QYLogoImageView) {
        
        _QYLogoImageView = [[UIImageView alloc]init];
        _QYLogoImageView.image = [UIImage imageNamed:@"QYLogo"];
        
    }
    return _QYLogoImageView;
}

-(UIButton *)logButton {
    
    if (!_logButton) {
        
        _logButton = [[UIButton alloc] init];
        [_logButton setTitle:@"登录" forState:UIControlStateNormal];
        _logButton.titleLabel.font = [UIFont systemFontOfSize:15.8];
        [_logButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logButton setBackgroundColor:[UIColor clearColor]];
        _logButton.tag = 0;
        [_logButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logButton;
}

-(UIButton *)registButton {
    
    if (!_registButton) {
        
        _registButton = [[UIButton alloc] init];
        [_registButton setTitle:@"注册" forState:UIControlStateNormal];
        _registButton.titleLabel.font = [UIFont systemFontOfSize:15.8];
        [_registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registButton setBackgroundColor:[UIColor clearColor]];
        _registButton.tag = 1;
        [_registButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registButton;
}
-(CAShapeLayer *)logTriangle {
    
    if (!_logTriangle) {
        
        _logTriangle = [[CAShapeLayer alloc] init];
        _logTriangle.lineWidth = 1.0;
        _logTriangle.fillColor = [UIColor whiteColor].CGColor;
        _logTriangle.hidden = NO;
    }
    return _logTriangle;
}

-(CAShapeLayer *)registertriangle {
    
    if (!_registertriangle) {
        
        _registertriangle = [[CAShapeLayer alloc] init];
        _registertriangle.lineWidth = 1.0;
        _registertriangle.fillColor = [UIColor whiteColor].CGColor;
        _registertriangle.hidden = YES;
    }
    return _registertriangle;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
