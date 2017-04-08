//
//  QYCommentNumberView.m
//  骑阅
//
//  Created by chen liang on 2017/4/9.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCommentNumberView.h"

@implementation QYCommentNumberView


+ (instancetype)loadCommentNumberView {
    
    QYCommentNumberView *view = [[NSBundle mainBundle] loadNibNamed:@"QYCommentNumberView" owner:nil options:nil].firstObject;
    return view;
}

- (void)setData:(NSArray *)data {
    
    _data = data;
    NSString *text = [NSString stringWithFormat:@"全部阅圈 (%lu）",(unsigned long)data.count];
    self.number.text = text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
