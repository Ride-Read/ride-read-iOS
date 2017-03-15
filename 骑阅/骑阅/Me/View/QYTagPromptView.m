//
//  QYTagPromptView.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYTagPromptView.h"
#import "YYLabel.h"
#import "UIView+Frame.h"
#import "UIColor+QYHexStringColor.h"


@interface QYTagPromptView ()
/** titleLabel */
@property(nonatomic,strong) YYLabel * titleLabel;
/** cutLine */
@property(nonatomic,strong) UIView * cutLineTop;
/** cutLine */
@property(nonatomic,strong) UIView * cutLineBottom;

@end



@implementation QYTagPromptView

+ (instancetype)creatView {
    
    return [[self alloc]init];
}
- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.QY_x = 30;
        self.QY_y = 30;
        self.QY_height = kScreenHeight - 2 * self.QY_y;
        self.QY_width = kScreenWidth - 2 * self.QY_x;
        [self setupUI];
    }
    return  self;
}


- (void)setupUI {
    
    self.titleLabel = [[YYLabel alloc]init];
    [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#52CAC1"]];
    self.titleLabel.textAlignment = 1;
    [self addSubview:self.titleLabel];
    
    self.cutLineTop = [[UIView alloc]init];
    self.cutLineTop.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.cutLineTop];
    
    self.cutLineBottom = [[UIView alloc]init];
    self.cutLineBottom.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.cutLineBottom];

    
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];

    
}


- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
