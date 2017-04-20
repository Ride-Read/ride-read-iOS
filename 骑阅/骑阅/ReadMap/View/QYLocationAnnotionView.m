//
//  QYLocationAnnotionView.m
//  骑阅
//
//  Created by chen liang on 2017/4/18.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLocationAnnotionView.h"
#import "define.h"

@implementation QYLocationAnnotionView

- (void)awakeFromNib {
    
    [super awakeFromNib];
}
+ (instancetype)locaView {
    
    QYLocationAnnotionView *locView = [[NSBundle mainBundle] loadNibNamed:@"QYLocationAnnotionView" owner:nil options:nil].firstObject;
    locView.frame = CGRectMake(0, 0,cl_caculation_3x(91),cl_caculation_3y(123));
    locView.backgroundColor = [UIColor clearColor];
    locView.currentIcon.layer.masksToBounds = YES;
    locView.currentIcon.layer.cornerRadius = cl_caculation_3x(71)/2;
    return locView;
}

- (void)setModel:(QYAnnotionModel *)model {
    
    _model = model;
    NSString *url = model.info[kcover];
    [self.currentIcon sd_setImageWithURL:[NSURL URLWithString:url]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
