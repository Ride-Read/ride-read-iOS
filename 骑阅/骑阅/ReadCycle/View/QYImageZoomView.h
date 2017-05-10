//
//  QYImageZoomView.h
//  骑阅
//
//  Created by chen liang on 2017/5/10.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewClickProtocol.h"

@interface QYImageZoomView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id <QYViewClickProtocol> delegate;
- (void)setImageViewWithImg:(UIImage *)img;

@end
