//
//  QYNamePromptView.m
//  骑阅
//
//  Created by 谢升阳 on 2017/3/15.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYNamePromptView.h"
#import "UIView+Frame.h"
#import "YYLabel.h"
#import "UIColor+QYHexStringColor.h"

@interface QYNamePromptView ()

/** titleLabel */
@property(nonatomic,strong) YYLabel * titleLabel;
/** cutLine */
@property(nonatomic,strong) UIView * cutLine;
/** subCutLine */
@property(nonatomic,strong) UIView * subCutLine;
/** cancleBtn */
@property(nonatomic,strong) UIButton * cancleBtn;
/** configBtn */
@property(nonatomic,strong) UIButton * configBtn;

@end

@implementation QYNamePromptView

+ (instancetype)creatView {
    
    return [[self alloc]init];
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.QY_x = self.sideMargin;
        self.QY_width = kScreenWidth - 2 * self.QY_x;
        self.QY_height = self.QY_width * 0.618;
        self.QY_y = (kScreenHeight - self.QY_height) * 0.5;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[YYLabel alloc]init];
    [self.titleLabel setTextColor:[UIColor colorWithHexString:@"#52CAC1"]];
    self.titleLabel.textAlignment = 1;
    [self addSubview:self.titleLabel];
    
    self.cutLine = [[UIView alloc]init];
    self.cutLine.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.cutLine];
    
    self.subCutLine = [[UIView alloc]init];
    self.subCutLine.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    [self addSubview:self.subCutLine];
    
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:self.cancleBtn];
    
    self.configBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.configBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.configBtn setTitleColor:[UIColor colorWithHexString:@"#52CAC1"] forState:UIControlStateNormal];
    [self addSubview:self.configBtn];

}
#pragma mark
- (CGFloat)sideMargin {
    
    return cl_caculation_3x(96);
}

- (void) setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [self.cutLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.titleLabel.mas_height);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5).offset(-0.5);
        make.right.mas_equalTo(self.configBtn.mas_left).offset(0);
    }];
    
    [self.configBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.cancleBtn.mas_height);
        make.left.mas_equalTo(self.cancleBtn.mas_right).offset(0);
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
