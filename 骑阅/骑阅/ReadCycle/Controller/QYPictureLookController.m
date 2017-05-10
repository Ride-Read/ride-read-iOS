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
#import "QYPictureCollectionLayout.h"
#import "QYPictureLookCollectionCell.h"
@interface QYPictureLookController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,QYViewClickProtocol>
@property (nonatomic, strong) QYPictureCollectionLayout *layout;


@end

@implementation QYPictureLookController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setContentView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    QYLookPictureTransionDelegate *delegate = self.transitioningDelegate;
    delegate.to = delegate.from;
    delegate.from = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
}


#pragma mark - target action

#pragma mark - gestrue
#pragma mark - private method

- (void)setContentView {
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.numberIndicator];
    self.numberIndicator.text = [NSString stringWithFormat:@"%ld/%lu",(self.currentIndex+1),(unsigned long)(self.imageArray.count)];
    self.layout.offsetpoint = CGPointMake(self.currentIndex * kScreenWidth, 0);
}

- (void)analyzeWith:(UIScrollView *)scrollView {
    
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    self.numberIndicator.text = [NSString stringWithFormat:@"%lu/%lu",index.row + 1,self.imageArray.count];
    self.cell = [self.collectionView cellForItemAtIndexPath:index];
    QYLookPictureTransionDelegate *delegate = self.transitioningDelegate;
    delegate.from = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    NSValue *to = self.rectFrame[index.row];
    CGRect toFrame = to.CGRectValue;
    delegate.to = toFrame;

}

#pragma mark - clickCustom delegate

- (void)clickCustomView:(UIView *)customView index:(NSInteger)index {
    
    CGRect rect = [self.cell convertRect:self.icon.frame toView:self.view];
    [self.icon removeFromSuperview];
    self.icon.frame = rect;
    [self.view addSubview:self.icon];
    self.collectionView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - collectionView dataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyLog(@"++++++++++++");
    QYPictureLookCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picture" forIndexPath:indexPath];
    NSString *urlStr = self.imageArray[indexPath.row];
    [cell.activity startAnimating];
    cell.zoomView.delegate = self;
    [cell.zoomView.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [cell.zoomView setImageViewWithImg:image];
        [cell.activity stopAnimating];
        
    }];
    self.icon = cell.zoomView.imageView;
    self.cell = cell;
    return cell;
}


#pragma mark - collcetion delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   
    [self analyzeWith:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    

    [self analyzeWith:scrollView];
}


#pragma mark - getter and setter

- (UILabel *)numberIndicator {
    
    if (!_numberIndicator) {
        _numberIndicator = [[UILabel alloc] init];
        _numberIndicator.textColor = [UIColor whiteColor];
        _numberIndicator.font = [UIFont systemFontOfSize:14*SizeScale3x];
    }
    return _numberIndicator;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:self.layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[QYPictureLookCollectionCell class] forCellWithReuseIdentifier:@"picture"];
    }
    
    return _collectionView;
}

- (QYPictureCollectionLayout *)layout {
    
    if (!_layout) {
        
        _layout = [[QYPictureCollectionLayout alloc] init];
    }
    return _layout;
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
