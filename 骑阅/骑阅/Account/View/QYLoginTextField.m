//
//  QYLoginTextField.m
//  骑阅
//
//  Created by 亮 on 2017/2/19.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginTextField.h"
#import "UIColor+QYHexStringColor.h"
#import "Masonry.h"
#import "define.h"

@interface QYLoginTextField ()

@property (nonatomic, strong) CAShapeLayer *bottomLine;
@property (nonatomic, strong,readwrite) QYAcountTextFiled *textField;

@end
@implementation QYLoginTextField

#pragma mark - life cycle
-(instancetype)init {
    
    if (self = [super init]) {
        
        [self setUpUI];
    }
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(48, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - 48, self.bounds.size.height)];
    self.bottomLine.path = path.CGPath;
}

#pragma mark - priavte method

-(void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textField];
    [self.layer addSublayer:self.bottomLine];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(139);
        make.bottom.mas_equalTo(-14);
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(0);
    }];
       
}

#pragma mark - setters and getters
-(QYAcountTextFiled *)textField {
    
    if (!_textField) {
        _textField = [[QYAcountTextFiled alloc] init];
        [_textField setTintColor:[UIColor colorWithHexString:@"#52CAC1"]];
        _textField.font = [UIFont systemFontOfSize:15.4];
        
    }
    return _textField;
}
-(CAShapeLayer *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [[CAShapeLayer alloc] init];
        _bottomLine.lineWidth = 1.0;
        _bottomLine.strokeColor = [UIColor colorWithHexString:@"#EEEEEE"].CGColor;
    }
    return _bottomLine;
}

-(void)setType:(UIKeyboardType)type {
    
    _type = type;
    self.textField.keyboardType = type;
    
}
-(void)setPlaceHolder:(NSString *)placeHolder {
    
    self.textField.placeholder = placeHolder;
}

-(NSString *)text {
    
    return self.textField.text;
}
-(void)setTextFieldCenterLeft:(CGFloat)textFieldCenterLeft {
    
    _textFieldCenterLeft = textFieldCenterLeft;
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.mas_centerX).offset(-_textFieldCenterLeft);
        make.bottom.mas_equalTo(-cl_caculation_y(self.textFieldBottom * 2));
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(0);
    }];
}
-(void)setTextFieldBottom:(CGFloat)textFieldBottom {
    
    _textFieldBottom = textFieldBottom;
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_centerX).offset(-_textFieldCenterLeft);
        make.bottom.mas_equalTo(-cl_caculation_y(self.textFieldBottom * 2));
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(0);
    }];
}
-(void)setTextFieldLeft:(CGFloat)textFieldLeft {
    
    _textFieldLeft = textFieldLeft;
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(-_textFieldLeft);
        make.bottom.mas_equalTo(-cl_caculation_y(self.textFieldBottom * 2));
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(0);
    }];
}

@end
