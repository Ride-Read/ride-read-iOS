//
//  QYCycleTableHeaderView.m
//  骑阅
//
//  Created by chen liang on 2017/3/5.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCycleTableHeaderView.h"
#import "UIButton+QYTitleButton.h"
#import "define.h"

@interface QYCycleTableHeaderView ()
@property (nonatomic, strong) UIButton *replyCountButton;
@property (nonatomic, copy) NSString *title;

@end
@implementation QYCycleTableHeaderView

+ (instancetype)headerViewWithTitle:(NSString *)title {
    
    return [[self alloc] initWithReplyTitle:title];
}

- (instancetype)initWithReplyTitle:(NSString *)title {
    
    self = [super init];
    self.title = title;
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.replyCountButton];
    [self.replyCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(133);
        make.height.mas_equalTo(33.5);
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(22);
    }];
}

-(UIButton *)replyCountButton {
    
    if (!_replyCountButton) {
        
        _replyCountButton = [UIButton buttonTitle:_title font:14 colco:[UIColor whiteColor]];
    }
    return _replyCountButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
