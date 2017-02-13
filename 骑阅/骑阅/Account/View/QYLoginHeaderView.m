//
//  QYLoginHeaderView.m
//  骑阅
//
//  Created by chen liang on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYLoginHeaderView.h"

@implementation QYLoginHeaderView


#pragma mark - setters and getters
-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        
    }
    return _titleLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
