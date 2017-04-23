//
//  QYCustomAnnotionView.m
//  骑阅
//
//  Created by chen liang on 2017/4/21.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCustomAnnotionView.h"
#import "define.h"

@interface QYCustomAnnotionView ()
@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *number;

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
        self.frame = self.bg.bounds;
        
    }
    return self;
}
- (void)setAnnotation:(id<MAAnnotation>)annotation {
    
    [super setAnnotation:annotation];
    QYAnnotionModel *annot = (QYAnnotionModel *)annotation;
    NSString *url = annot.info[kcover];
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

- (UILabel *)number {
    
    if (!_number) {
        
        _number = [[UILabel alloc] init];
    }
    return _number;
}
@end
