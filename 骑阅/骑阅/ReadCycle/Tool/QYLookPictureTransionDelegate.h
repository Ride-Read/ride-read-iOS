//
//  QYLookPictureTransionDelegate.h
//  骑阅
//
//  Created by chen liang on 2017/4/16.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QYLookPictureTransionDelegate : NSObject<UIViewControllerTransitioningDelegate>
@property (nonatomic, assign) CGRect from;
@property (nonatomic, assign) CGRect to;

@end
