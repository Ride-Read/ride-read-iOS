//
//  QYCustomPresentAnimationDelegate.h
//  骑阅
//
//  Created by 亮 on 2017/2/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,QYLogTransitionType) {
    
    QYLogTransitionTypePresent,
    QYLogTransitionTypeDismiss
};


@interface QYCustomPresentAnimationDelegate : NSObject<UIViewControllerAnimatedTransitioning>
+(instancetype)customPresentAnimationWithType:(QYLogTransitionType)type;

@end
