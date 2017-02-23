//
//  QYTabBarSliderTransitionAnimation.h
//  骑阅
//
//  Created by 亮 on 2017/2/23.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,CLTabBarSliderDirection) {
    
    CLTabBarSliderDirectionLeft,
    CLTabBarSliderDirectionRight
};

@interface QYTabBarSliderTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithDirection:(CLTabBarSliderDirection)direction;

@end
