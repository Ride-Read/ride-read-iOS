//
//  QYimageView.m
//  骑阅
//
//  Created by chen liang on 2017/4/11.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYimageView.h"
#import "define.h"

@interface QYimageView ()


@end
@implementation QYimageView

- (instancetype)init {
    
    self = [super init];
    [self setupui];
    return self;
}

- (void)setupui {
    
    [self addSubview:self.icon];
    [self addSubview:self.delegateButton];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.top.and.bottom.mas_equalTo(0);
    }];
    
    [self.delegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.icon.mas_right);
        make.top.equalTo(self.icon.mas_top);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
}

- (void)deleteSelf {
    
    if (self.next && self.last) {
        
        [self.next mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.last.mas_right).offset(2);
            make.width.mas_equalTo(self.last.mas_width);
            make.height.mas_equalTo(self.last.mas_height);
            make.top.equalTo(self.last.mas_top);
            make.bottom.equalTo(self.last.mas_bottom);

            
        }];
        self.last.next = self.next;
        self.next.last = self.last;
        [self removeFromSuperview];
        return;
       
    }
    
    if (self.next && !self.last) {
        
        [self.next mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
            
        }];
        self.last.last = nil;
        [self removeFromSuperview];
        return;

        
    }
    
    if (self.last && !self.next) {
        
        
        self.last.next = nil;
        [self removeFromSuperview];
        return;
    }
    
    if (!self.last && !self.next) {
        
        [self removeFromSuperview];
        return;
    }
}

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [UIImageView new];
    }
    return _icon;
}

- (UIButton *)delegateButton {
    
    if (!_delegateButton) {
        
        _delegateButton = [[UIButton alloc] init];
        [_delegateButton setBackgroundImage:[UIImage imageNamed:@"post_close"] forState:UIControlStateNormal];
        [_delegateButton addTarget:self action:@selector(deleteSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delegateButton;
}

- (void)setNext:(QYimageView *)next {
    
    _next = next;
    if (!self.next) {
        
        return;
    }
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_right).offset(2);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
