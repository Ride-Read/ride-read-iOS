//
//  QYReadMeHeaderView.m
//  骑阅
//
//  Created by chen liang on 2017/3/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYReadMeHeaderView.h"
#import "UIColor+QYHexStringColor.h"
#import "UIButton+QYTitleButton.h"
#import "define.h"
#import "UIView+YYAdd.h"

@interface QYReadMeHeaderView ()
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *username;
@property (nonatomic, strong) UIImageView *sexIcon;
@property (nonatomic, strong) UIButton *personMap;
@property (nonatomic, strong) UILabel *personSignature;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *attentionButton;
@property (nonatomic, strong) UIButton *fansButton;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *grayView;
@end
@implementation QYReadMeHeaderView

- (instancetype)init {
    
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.bottomView];
    [self addSubview:self.icon];
    [self addSubview:self.username];
    [self addSubview:self.sexIcon];
    [self addSubview:self.personMap];
    [self addSubview:self.personMap];
    [self addSubview:self.grayView];
    [self.bottomView addSubview:self.personSignature];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-60);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(75);
    }];
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.top.equalTo(self.icon.mas_top);
    }];
    [self.sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.username.mas_right).offset(5);
        make.top.equalTo(self.username.mas_top);
        make.bottom.equalTo(self.username.mas_bottom);
        make.width.mas_equalTo(10);
    }];
    [self.personMap mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.icon.mas_top);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(85);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(75);
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.bottomView.mas_bottom);
        make.right.and.left.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(5);
    }];
    [self.bottomView addSubview:self.personSignature];
    [self.bottomView addSubview:self.messageButton];
    [self.bottomView addSubview:self.attentionButton];
    [self.bottomView addSubview:self.fansButton];
    
    [self.personSignature mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(75 + 10 + 15);
        make.top.mas_equalTo(8);
    }];
    
    UIView *line_1 = [UIView new];
    UIView *line_2 = [UIView new];
    line_1.backgroundColor = [UIColor colorWithHexString:@"#555555"];
    line_2.backgroundColor = [UIColor colorWithHexString:@"#555555"];
    [self.bottomView addSubview:line_1];
    [self.bottomView addSubview:line_2];
    [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(kScreenWidth/3);
        make.width.mas_equalTo(0.5);
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(-10);
    }];
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kScreenWidth/3 * 2);
        make.width.mas_equalTo(0.5);
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(-10);
    }];
    self.messageButton.left = 0;
    self.messageButton.top = 35;
    self.messageButton.size = CGSizeMake(kScreenWidth/3, 40);
    self.attentionButton.frame = CGRectOffset(self.messageButton.frame, kScreenWidth/3, 0);
    self.fansButton.frame = CGRectOffset(self.attentionButton.frame, kScreenWidth/3, 0);

}
#pragma mark - target action
- (void)clickButton:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            if ([self.delegate respondsToSelector:@selector(clickIcon:)]) {
                
                [self.delegate clickIcon:self];
            }
            break;

        }
            case 1:
        {
            
            if ([self.delegate respondsToSelector:@selector(clickPersonMap:)]) {
                
                [self.delegate clickPersonMap:self];
            }
            break;

        }
            case 2:
        {
            
            if ([self.delegate respondsToSelector:@selector(clickMessageButton:)]) {
                
                [self.delegate clickMessageButton:self];
            }
            break;

        }
            case 3:
        {
            
            if ([self.delegate respondsToSelector:@selector(clickAttentionButton:)]) {
                
                [self.delegate clickAttentionButton:self];
            }
            break;

        }
            case 4:
        {
            
            if ([self.delegate respondsToSelector:@selector(clickFansButton:)]) {
                
                [self.delegate clickFansButton:self];
            }
            break;
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark setter and getter
- (UIButton *)icon {
    
    if (!_icon) {
        
        _icon = [[UIButton alloc] init];
        _icon.layer.cornerRadius = 4.0;
        _icon.backgroundColor = [UIColor colorWithRed:0.00 green:0.81 blue:0.77 alpha:1.00];
        [_icon addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _icon;
}

- (UILabel *)username {
    
    if (!_username) {
        
        _username = [[UILabel alloc] init];
        _username.textColor = [UIColor colorWithHexString:@"#555555"];
        _username.font = [UIFont systemFontOfSize:12];
        
    }
    return _username;
}

- (UIImageView *)sexIcon {
    
    if (!_sexIcon) {
        
        _sexIcon = [[UIImageView alloc] init];
    }
    return _sexIcon;
}
- (UIButton *)personMap {
    
    if (!_personMap) {
        
        _personMap = [UIButton buttonTitle:@"个性地图" font:12 colco:[UIColor whiteColor]];
        [_personMap addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _personMap.backgroundColor = [UIColor colorWithRed:0.00 green:0.81 blue:0.77 alpha:1.00];
        _personMap.layer.cornerRadius = 4.0;
    }
    return _personMap;
}
- (UILabel *)personSignature {
    
    if (!_personSignature) {
        
        _personSignature = [UILabel new];
        _personSignature.textColor = [UIColor colorWithHexString:@"#555555"];
        _personSignature.font = [UIFont systemFontOfSize:10];
    }
    return  _personSignature;
}

- (UIButton *)messageButton {
    
    if (!_messageButton) {
        
        _messageButton = [UIButton buttonTitle:@"消息" font:11 colco:[UIColor colorWithHexString:@"#555555"]];
        _messageButton.tag = 2;
        [_messageButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageButton;
}

- (UIButton *)attentionButton {
    
    if (!_attentionButton) {
        
        _attentionButton = [UIButton buttonTitle:@"关注" font:11 colco:[UIColor colorWithHexString:@"#555555"]];
        _attentionButton.tag = 3;
        [_attentionButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionButton;
}
- (UIView *)grayView {
    
    if (!_grayView) {
        _grayView = [UIView new];
        _grayView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    }
    return _grayView;
}

- (UIButton *)fansButton {
    
    if (!_fansButton) {
        
        _fansButton = [UIButton buttonTitle:@"粉丝" font:11 colco:[UIColor colorWithHexString:@"#555555"]];
        _fansButton.tag = 4;
        [_fansButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fansButton;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
