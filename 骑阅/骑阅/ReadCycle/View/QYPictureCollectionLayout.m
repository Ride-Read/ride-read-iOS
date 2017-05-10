//
//  QYPictureCollectionLayout.m
//  骑阅
//
//  Created by chen liang on 2017/5/8.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "QYPictureCollectionLayout.h"
#import "define.h"

@implementation QYPictureCollectionLayout

- (instancetype)init {
    
    self = [super init];
    [self configProperty];
    return self;
}

- (void)configProperty {
    
    self.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
- (void)prepareLayout{
    
    [super prepareLayout];
    self.collectionView.contentOffset = self.offsetpoint;
    
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds{
    
    
    return NO;
    
}



@end
