//
//  QYInviteView.m
//  骑阅
//
//  Created by 亮 on 2017/2/20.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYInviteView.h"
#import "UIColor+QYHexStringColor.h"
#import "define.h"
#import "Masonry.h"

@implementation QYInviteView

#pragma mark - life cycle
-(instancetype)init {
    
    self = [super init];
    [self setUpUI];
    return self;
}

#pragma mark - private method
-(void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.invitePeople];
    [self addSubview:self.invite];
    [self addSubview:self.nextSetup];
    [self.invite mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(cl_caculation_y(78 * 2));
    }];
    [self.invitePeople mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(0);
        make.top.equalTo(self.invite.mas_bottom);
        make.height.mas_equalTo(cl_caculation_y(58 * 2));
    }];
    
    [self.nextSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.invitePeople.mas_bottom).offset(cl_caculation_y(69.3 * 2));
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
-(QYLoginTextField *)invite {
    
    if (!_invite) {
        
        _invite = [[QYLoginTextField alloc] init];
        _invite.textField.text = @"填写邀请码";
        _invite.textField.textColor =  [UIColor colorWithHexString:@"#555555"];
        _invite.textField.enabled = NO;
        _invite.textFieldCenterLeft = 15 * 2.5;
        _invite.textFieldBottom = 0;
    }
    return _invite;
}
-(QYLoginTextField *)invitePeople {
    
    if (!_invitePeople) {
        
        _invitePeople = [[QYLoginTextField alloc] init];
        _invitePeople.placeHolder = @"邀请人的骑阅号";
        _invitePeople.textFieldCenterLeft = 15 * 3.5;
        if (kScreenHeight < 560) {
            
            _invitePeople.textFieldBottom = 6;
        } else {
            
            _invitePeople.textFieldBottom = 8;
        }
    }
    return _invitePeople;
}
-(UIButton *)nextSetup {
    
    if (!_nextSetup) {
        
        _nextSetup = [[UIButton alloc] init];
        _nextSetup.tag = 0;
        [_nextSetup setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextSetup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextSetup.titleLabel.font = [UIFont systemFontOfSize:15.5];
        [_nextSetup setBackgroundImage:[UIImage imageNamed:@"log_button_radiu"] forState:UIControlStateNormal];
        [_nextSetup addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextSetup;

}

@end
