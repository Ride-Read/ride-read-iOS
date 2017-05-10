//
//  QYImageZoomView.m
//  骑阅
//
//  Created by chen liang on 2017/5/10.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYImageZoomView.h"
#define HandDoubleTap 2
#define HandOneTap 1
#define MaxZoomScaleNum 2.0
#define MinZoomScaleNum 1.0
#import "define.h"

@implementation QYImageZoomView

- (instancetype)init {
    
    self = [super init];
    [self setupui];
    return self;
}

- (void)setupui {
    
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
        
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.and.top.and.bottom.mas_equalTo(0);
    }];
        
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_imageView];
        //双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(TapsAction:)];
    [doubleTapGesture setNumberOfTapsRequired:HandDoubleTap];
    [_imageView addGestureRecognizer:doubleTapGesture];
        
        //单击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(TapsAction:)];
    [tapGesture setNumberOfTapsRequired:HandOneTap];
    [_imageView addGestureRecognizer:tapGesture];
        
        //双击失败之后执行单击
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
        self.scrollView.maximumZoomScale = MaxZoomScaleNum;
        self.scrollView.minimumZoomScale = MinZoomScaleNum;
        self.scrollView.zoomScale = MinZoomScaleNum;

}

#pragma mark- 手势事件
//单击 / 双击 手势
- (void)TapsAction:(UITapGestureRecognizer *)tap
{
    NSInteger tapCount = tap.numberOfTapsRequired;
    if (HandDoubleTap == tapCount) {
        //双击
        NSLog(@"双击");
        if (self.scrollView.minimumZoomScale <= self.scrollView.zoomScale && self.scrollView.maximumZoomScale > self.scrollView.zoomScale) {
            [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
        }else {
            [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
        }
        
    }else if (HandOneTap == tapCount) {
        //单击
        if (self.scrollView.minimumZoomScale != self.scrollView.zoomScale) {
            
            [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
            return;
        }
        if ([self.delegate respondsToSelector:@selector(clickCustomView:index:)]) {
            
            [self.delegate clickCustomView:self index:0];
        }
        
    }
}

- (float )getImageWidthFator {
    
    return self.bounds.size.width / self.image.size.width;
}

- (float)getImageHeightFactor {
    
    return self.bounds.size.height / self.image.size.height;
}

- (CGSize)newSizeByoriginalSize:(CGSize)origin maxSize:(CGSize)maxSize {
    
    if (origin.width <= 0 || origin.height <= 0) {
        return CGSizeZero;
    }
    
    CGSize newSize = CGSizeZero;
    if (origin.width > maxSize.width || origin.height > maxSize.height) {
        //按比例计算尺寸
        float bs = [self getImageWidthFator];
        float newHeight = origin.height * bs;
        newSize = CGSizeMake(maxSize.width, newHeight);
        
        if (newHeight > maxSize.height) {
            bs = [self getImageHeightFactor];
            float newWidth = origin.width * bs;
            newSize = CGSizeMake(newWidth, maxSize.height);
        }
    }else {
        
        newSize = origin;
    }
    return newSize;
}

- (void)setImageViewWithImg:(UIImage *)img {
    self.scrollView.scrollEnabled = YES;
    
    self.image = img;
    self.imageView.image = img;
    CGSize showSize = [self newSizeByoriginalSize:img.size maxSize:self.bounds.size];
    self.imageView.frame = CGRectMake((kScreenWidth-showSize.width)/2, (kScreenHeight-showSize.height)/2, showSize.width, showSize.height);
    
    _scrollView.zoomScale = 1;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.zoomScale  = _scrollView.minimumZoomScale;
    
}
#pragma mark - scrollview delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.frame.size.width;
    CGFloat H = _imageView.frame.size.height;
    
    CGRect rct = _imageView.frame;
    rct.origin.x = MAX((Ws-W)*0.5, 0);
    rct.origin.y = MAX((Hs-H)*0.5, 0);
    _imageView.frame = rct;
    
}

@end
