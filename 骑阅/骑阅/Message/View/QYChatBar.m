//
//  QYChatBar.m
//  骑阅
//
//  Created by chen liang on 2017/4/2.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYChatBar.h"
#import <Masonry/Masonry.h>
#import "UIButton+QYTitleButton.h"
#import "define.h"

@interface QYChatBar ()

@property (nonatomic, strong) UIButton *sendButton;

@end
@implementation QYChatBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self  = [super initWithFrame:frame];
    self.textView.returnKeyType = UIReturnKeyDefault;
    self.voiceButton.hidden = YES;
    self.moreButton.hidden = YES;
    return self;
}

- (void)setupConstraints {
    
    [self.inputBarBackgroundView addSubview:self.sendButton];
    [super setupConstraints];
    [self.voiceButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.moreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(cl_caculation_3x(15));
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(5);
        make.right.equalTo(self.faceButton.mas_left).offset(cl_caculation_3x(16));
    }];
    
    [self.faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        //make.width.mas_equalTo(cl_caculation_3x(60));
        make.height.equalTo(self.faceButton.mas_width);
        make.top.equalTo(self.textView.mas_top);
        make.bottom.equalTo(self.textView.mas_bottom);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.faceButton.mas_right).offset(7);
        make.top.equalTo(self.textView.mas_top);
        make.bottom.equalTo(self.textView.mas_bottom);
        make.right.equalTo(self.inputBarBackgroundView.mas_right).offset(-15);
        make.width.mas_equalTo(cl_caculation_3x(120));
       
    }];
    
}

- (void)clickSendAction:(UIButton *)sender {
    
    [self sendTextMessage:self.textView.text];
}

- (UIButton *)sendButton {
    
    if (!_sendButton) {
        
        _sendButton = [UIButton buttonTitle:@"发送" font:12.5 colco:[UIColor whiteColor]];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _sendButton.backgroundColor = [UIColor colorWithRed:0.00 green:0.81 blue:0.77 alpha:1.00];
        [_sendButton addTarget:self action:@selector(clickSendAction:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.layer.cornerRadius = 5.0;
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
