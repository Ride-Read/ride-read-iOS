//
//  QYPictureLookController.m
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPictureLookController.h"
#import "define.h"
#import <math.h>
#import "QYLookPictureTransionDelegate.h"
@interface QYPictureLookController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>


@end

@implementation QYPictureLookController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setContentView];
    [self addGesture];
//    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    QYLookPictureTransionDelegate *delegate = self.transitioningDelegate;
    delegate.to = delegate.from;
    delegate.from = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
}

- (void)setContentView {
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.numberIndicator];
    [self.scrollView addSubview:self.icon];
    self.numberIndicator.text = [NSString stringWithFormat:@"%ld/%lu",(self.currentIndex+1),(unsigned long)(self.imageArray.count)];
//    self.icon.image = self.imageArray[self.currentIndex];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.imageArray[self.currentIndex]]];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.imageArray.count, kScreenHeight);
    
}


#pragma mark - target action 

- (void)clickTap:(UIGestureRecognizer *)tap {
    
    if ([tap isKindOfClass:[UITapGestureRecognizer class]]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    if ([tap isKindOfClass:[UILongPressGestureRecognizer class]]) {
        
        
    }
    
}

#pragma mark - gestrue
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}
#pragma mark - private method

- (void)addGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    UILongPressGestureRecognizer *pres = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    [self.view addGestureRecognizer:pres];
    
}


- (void)analyze {
    
    CGPoint offest = self.scrollView.contentOffset;
    int left = rint(offest.x/kScreenWidth);
    self.currentIndex = left;
    self.icon.frame = CGRectMake(left * kScreenWidth, 100, kScreenWidth, kScreenHeight - 200);
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.imageArray[self.currentIndex]]];
    self.numberIndicator.text = [NSString stringWithFormat:@"%d/%lu",(left+1),(unsigned long)(self.imageArray.count)];
    QYLookPictureTransionDelegate *delegate = self.transitioningDelegate;
    delegate.from = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    NSValue *to = self.rectFrame[left];
    CGRect toFrame = to.CGRectValue;
    delegate.to = toFrame;
    
}
#pragma mark - scrollview delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self analyze];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
   
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.icon;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
    self.scrollView.scrollEnabled = NO;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    self.scrollView.contentOffset = CGPointMake(self.currentIndex * kScreenWidth, 0);
}

#pragma mark - getter and setter

- (UIImageView *)icon {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds = YES;
        _icon.userInteractionEnabled = YES;

    }
    return _icon;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        
    }
    
    return _scrollView;
}
- (UILabel *)numberIndicator {
    
    if (!_numberIndicator) {
        _numberIndicator = [[UILabel alloc] init];
        _numberIndicator.textColor = [UIColor whiteColor];
        _numberIndicator.font = [UIFont systemFontOfSize:14*SizeScale3x];
    }
    return _numberIndicator;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
