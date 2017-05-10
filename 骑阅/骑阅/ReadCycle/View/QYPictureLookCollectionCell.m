//
//  QYPictureLookCollectionCell.m
//  骑阅
//
//  Created by chen liang on 2017/5/8.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPictureLookCollectionCell.h"
#import "define.h"

@implementation QYPictureLookCollectionCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self setupui];
    return self;
}
- (instancetype)init {
    
    self = [super init];
    [self setupui];
    return self;
}


- (void)setupui {
    
    [self.contentView addSubview:self.zoomView];
    [self.contentView addSubview:self.activity];
    [self.zoomView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
        
    }
    return _icon;
}

- (QYImageZoomView *)zoomView {
    
    if (!_zoomView) {
        
        _zoomView = [[QYImageZoomView alloc] init];
        _zoomView.frame = self.bounds;
    }
    return _zoomView;
}

- (UIActivityIndicatorView *)activity {
    
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 10, kScreenHeight/2 - 10, 20, 20)];
        _activity.color = [UIColor whiteColor];
        _activity.hidesWhenStopped = YES;
    }
    return _activity;
}

- (void)prepareForReuse {
    
    [super prepareForReuse];
    [self.activity stopAnimating];
}

@end
