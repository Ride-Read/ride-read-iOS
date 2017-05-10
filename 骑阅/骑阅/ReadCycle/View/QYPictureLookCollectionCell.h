//
//  QYPictureLookCollectionCell.h
//  骑阅
//
//  Created by chen liang on 2017/5/8.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYBasicCollectionViewCell.h"
#import "QYImageZoomView.h"

@interface QYPictureLookCollectionCell : QYBasicCollectionViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) QYImageZoomView *zoomView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

@end
