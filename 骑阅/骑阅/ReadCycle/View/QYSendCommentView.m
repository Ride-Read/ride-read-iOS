
//  QYSendCommentView.m
//  骑阅
//
//  Created by chen liang on 2017/3/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSendCommentView.h"
#import "UIView+YYAdd.h"
#import "UIButton+QYTitleButton.h"
#import "define.h"

@interface QYSendCommentView ()
@property (nonatomic ,strong) UIButton *praiseButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendButton;
@end

@implementation QYSendCommentView

- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self addSubview:self.praiseButton];
    [self addSubview:self.textField];
    [self addSubview:self.sendButton];
    self.praiseButton.left = 16;
    self.praiseButton.top = 6;
    self.praiseButton.size = CGSizeMake(44, 40);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.praiseButton.mas_right).offset(5.5);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.sendButton.mas_left).offset(-5.5);
    }];
    self.sendButton.size = CGSizeMake(58, 40);
    self.sendButton.top = 6;
    self.sendButton.left = kScreenWidth - 16 - 58;
    
}

- (UIButton *)praiseButton {
    
    if (!_praiseButton) {
        
        _praiseButton = [UIButton new];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"click_up_selected"] forState:UIControlStateNormal];
    }
    return _praiseButton;
}

- (UITextField *)textField {
    if (!_textField) {
        
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:14];
        //_textField.attributedPlaceholder = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        _textField.placeholder = @"   说的什么";
    }
    return _textField;
}

- (UIButton *)sendButton {
    
    if (!_sendButton) {
        _sendButton = [UIButton buttonTitle:@"发送" font:14 colco:[UIColor whiteColor]];
        [_sendButton setBackgroundColor:[UIColor colorWithRed:0.32 green:0.79 blue:0.76 alpha:1.00]];
        _sendButton.layer.cornerRadius = 5;
       }
    return _sendButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
