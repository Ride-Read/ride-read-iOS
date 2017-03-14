//
//  QYCommentSectionView.m
//  骑阅
//
//  Created by chen liang on 2017/3/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCommentSectionView.h"
#import "define.h"
#import "UIColor+QYHexStringColor.h"

@interface QYCommentSectionView ()
@property (nonatomic, strong) UIView *grayView;
@end
@implementation QYCommentSectionView


- (instancetype)init {
    
    self = [super init];
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.grayView];
    [self addSubview:self.commentNumber];
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(5);
    }];
    [self.commentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(-12);
    }];
    [self showBottomLine];
}

- (UIView *)grayView {
    
    if (!_grayView) {
        
        _grayView = [UIView new];
        _grayView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    }
    return _grayView;
}
- (UILabel *)commentNumber {
    
    if (!_commentNumber) {
        _commentNumber = [[UILabel alloc] init];
        _commentNumber.textColor = [UIColor colorWithHexString:@"#555555"];
        _commentNumber.font = [UIFont systemFontOfSize:14];
    }
    return _commentNumber;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
