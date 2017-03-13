//
//  QYCommentViewCell.m
//  骑阅
//
//  Created by chen liang on 2017/3/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYCommentViewCell.h"
#import "define.h"
#import "UIView+YYAdd.h"

@implementation QYCommentViewCell

- (instancetype)init {

    self = [super init];
    return self;
}

- (void)setupUI {
    
    
}

- (void)layoutIcon {
    
    
}

- (void)layoutNikeName {
    
    
}

- (void)layoutTime {
    
    
}

- (void)layoutComment {
    
    self.comment.left = 56;
    self.comment.top = CGRectGetMaxY(self.timeLabel.frame) + 14.5;

}

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (YYLabel *)nickName {
    
    if (!_nickName) {
        
        _nickName = [[YYLabel alloc] init];
        _nickName.displaysAsynchronously = YES;
        _nickName.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
            
        };
    }
    return _nickName;
}

- (YYLabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[YYLabel alloc] init];
        _timeLabel.displaysAsynchronously = YES;
    }
    return _timeLabel;
}

- (YYLabel *)comment {
    
    if (!_comment) {
        
        _comment = [[YYLabel alloc] init];
        _comment.displaysAsynchronously = YES;
        _comment.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
        };
    }
    return _comment;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
