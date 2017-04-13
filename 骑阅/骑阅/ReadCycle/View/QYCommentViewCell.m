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
#import "UIImageView+WebCache.h"

@implementation QYCommentViewCell

- (instancetype)init {

    self = [super init];
    [self setupUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setupUI {
    
    self.showBottomLine = YES;
    [self addSubview:self.icon];
    [self addSubview:self.nickName];
    [self addSubview:self.timeLabel];
    [self addSubview:self.comment];
    
}

- (void)layoutIcon {
    
    self.icon.left = 15;
    self.icon.top = 11;
    self.icon.size = CGSizeMake(30, 30);
    NSString *urlString = _layout.status[kface_url];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)layoutNikeName {
    
    self.nickName.top = 13;
    self.nickName.left = CGRectGetMaxX(self.icon.frame) + 11.5;
    self.nickName.size = _layout.nikeNameLayout.textBoundingSize;
    self.nickName.textLayout = _layout.nikeNameLayout;
}

- (void)layoutTime {
    
    self.timeLabel.top = CGRectGetMaxY(self.nickName.frame) + 5;
    self.timeLabel.left = self.nickName.left;
    self.timeLabel.size = _layout.timeLayout.textBoundingSize;
    self.timeLabel.textLayout = _layout.timeLayout;

}

- (void)layoutComment {
    
    self.comment.left = 56;
    self.comment.top = CGRectGetMaxY(self.timeLabel.frame) + 14.5;
    self.comment.size = _layout.commentLayout.textBoundingSize;
    self.comment.textLayout = _layout.commentLayout;

}
- (void)setLayout:(QYCommpentCellLayout *)layout {
    
    _layout = layout;
    [self layoutIcon];
    [self layoutNikeName];
    [self layoutTime];
    [self layoutComment];
}

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
        _icon.backgroundColor = [UIColor greenColor];
    }
    return _icon;
}

- (YYLabel *)nickName {
    
    if (!_nickName) {
        
        _nickName = [[YYLabel alloc] init];
        _nickName.displaysAsynchronously = YES;
        _nickName.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
            NSLog(@"----------");
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
        WEAKSELF(_self);
        _comment.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
            if ([_self.delegate respondsToSelector:@selector(commentCell:data:)]) {
               
                [_self.delegate commentCell:_self data:_self.layout.status];
            }
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
