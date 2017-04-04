//
//  QYSearchView.m
//  骑阅
//
//  Created by chen liang on 2017/3/26.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYSearchView.h"
#import "UIButton+QYTitleButton.h"
#import "define.h"

@interface QYSearchView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) UIButton *confirm;
@property (nonatomic, strong) UIImageView *bg;
@end
@implementation QYSearchView

+ (instancetype)searchViewLogic:(id<QYSearchViewProtocol>)logic {
    
    return [[self alloc] initWithLogic:logic];
}
- (instancetype)initWithLogic:(id<QYSearchViewProtocol>)logic {
    
    self = [super init];
    self.logic = logic;
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bg];
    [self addSubview:self.searchBar];
    [self addSubview:self.confirm];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(23);
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(3);
        make.right.equalTo(self.confirm.mas_left).offset(-17);
    }];
    [self.confirm mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.searchBar.mas_top);;
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(35);
        
    }];
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(3);
        make.right.equalTo(self.confirm.mas_left).offset(-10);

    }];
}

- (UITextField *)searchBar {
    
    if (!_searchBar) {
        
        _searchBar = [[UITextField alloc] init];
        _searchBar.borderStyle = UITextBorderStyleNone;
        _searchBar.delegate = self;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"  输入您想搜索的关键字"];
        [text addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"]} range:NSMakeRange(0, text.length)];
        _searchBar.attributedPlaceholder = text;
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.tintColor = [UIColor colorWithHexString:@"52cac1"];
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索"]];
        _searchBar.rightViewMode = UITextFieldViewModeWhileEditing;
        UIButton *right = [UIButton new];
        right.frame = CGRectMake(0, 0, 20, 20);
        [right setBackgroundImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [right addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
        _searchBar.rightView = right;
        _searchBar.returnKeyType = UIReturnKeySearch;
        [_searchBar addTarget:self action:@selector(textFiledDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchBar;
}
-(UIImageView *)bg {
    
    if (!_bg) {
        
        _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆角矩形"]];
    }
    return _bg;
}

- (UIButton *)confirm {
    
    if (!_confirm) {
        
        _confirm = [UIButton buttonTitle:@"取消" font:14 colco:[UIColor colorWithHexString:@"#555555"]];
        [_confirm addTarget:self action:@selector(clickCancleButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirm;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.searchBar endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([self.logic respondsToSelector:@selector(searchView:textEndChange:)]) {
        
        [self.logic searchView:self textEndChange:self.searchBar.text];
    }
}

- (void)textFiledDidChangeValue:(UITextField *)field {
    
    if ([self.logic respondsToSelector:@selector(searchBar:textDidChange:)]) {
        
        [self.logic searchView:self textEndChange:field.text];
    }
}

- (void)clickCancleButton:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
        
        [self.delegate clickCustomView:self index:0];
    }
}

- (void)clearText {
    
    self.searchBar.text = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
