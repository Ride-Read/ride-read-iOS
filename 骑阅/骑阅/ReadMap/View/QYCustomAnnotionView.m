//
//  QYCustomAnnotionView.m
//  骑阅
//
//  Created by chen liang on 2017/4/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCustomAnnotionView.h"
#import "define.h"
#import "UIButton+QYTitleButton.h"

@interface QYCustomAnnotionView ()

@end
@implementation QYCustomAnnotionView


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:self animated:animated];
}
- (void)setSelected:(BOOL)selected {
    
    if (self.selected == selected) {
        
        return;
    }
    [super setSelected:selected];
}


- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self addSubview:self.bg];
        [self addSubview:self.icon];
        [self addSubview:self.number];
        self.bg.frame = CGRectMake(0, 0,cl_caculation_3x(91),cl_caculation_3y(123));
        self.icon.frame = CGRectMake(5, 5, cl_caculation_3x(71), cl_caculation_3x(71));
        [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(5);
            make.top.mas_equalTo(-5);
            make.width.mas_equalTo(cl_caculation_3x(40));
            make.height.mas_equalTo(cl_caculation_3x(40));
        }];
        self.frame = self.bg.bounds;
        
    }
    return self;
}
- (void)setAnnotation:(id<MAAnnotation>)annotation {
    
    [super setAnnotation:annotation];
    QYAnnotionModel *annot = (QYAnnotionModel *)annotation;
    NSString *url = annot.info[kcover];
    [self.number setTitle:annot.info[kcount] forState:UIControlStateNormal];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url]];

}

#pragma mark - target action

- (void)clickCurrentIcon {
    
    if ([self.delegate respondsToSelector:@selector(clickCustomAnnotion:info:)]) {
        
        QYAnnotionModel *ann = self.annotation;
        [self.delegate clickCustomAnnotion:self info:ann.info];
    }
}

#pragma mark - getter and setter
- (UIImageView *)bg {
    
    if (!_bg) {
        
        _bg = [[UIImageView alloc] init];
        _bg.image = [UIImage imageNamed:@"sgin_no_icon"];
    }
    return _bg;
}

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc ] init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = cl_caculation_3x(71)/2;
    }
    return _icon;
}

- (UIButton *)number {
    
    if (!_number) {
        
        _number = [UIButton buttonTitle:@"0" font:8 colco:[UIColor whiteColor]];
        _number.backgroundColor = [UIColor colorWithRed:0.00 green:0.82 blue:0.77 alpha:1.00];
        _number.layer.cornerRadius = cl_caculation_3x(20);
        }
    return _number;
}
@end
