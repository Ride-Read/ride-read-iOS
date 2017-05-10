//
//  QYPictureLookController.h
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicViewController.h"

@interface QYPictureLookController : QYBasicViewController
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *rectFrame;
@property (strong, nonatomic)  UILabel *numberIndicator;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, weak) UICollectionViewCell *cell;
@property (nonatomic, strong) UICollectionView *collectionView;



@end
